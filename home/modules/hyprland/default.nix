{ pkgs, ... }:
let
  projector = pkgs.writeShellScriptBin "projector" ''
    #!/usr/bin/env bash
    set -euo pipefail

    # --- Defaults ---
    WORKSPACE_NUM="5"
    MODE="extend"        # extend | mirror | off
    TARGET_MONITOR=""    # Optional: specific monitor name
    DRY_RUN=false
    RETRY_COUNT=5
    RETRY_DELAY=0.5

    # --- Helpers ---
    log() { echo -e "[\033[1;34mINFO\033[0m] $*"; }
    warn() { echo -e "[\033[1;33mWARN\033[0m] $*" >&2; }
    error() { echo -e "[\033[1;31mERROR\033[0m] $*" >&2; exit 1; }

    usage() {
      cat <<EOF
    Usage: $(basename "$0") [options]
    Options:
      -w <num>    Workspace number (default: $WORKSPACE_NUM)
      -m <mode>   Mode: extend (default), mirror, off
      -s <name>   Specific monitor name to target
      -d          Dry run (print commands instead of executing)
      -h          Show this help
    EOF
      exit 0
    }

    run_hyprctl() {
      if [ "$DRY_RUN" = true ]; then
        echo "[DRY-RUN] hyprctl $*"
      else
        hyprctl "$@" > /dev/null
      fi
    }

    # --- Parse Args ---
    while getopts "w:m:s:dh" opt; do
      case "$opt" in
        w) WORKSPACE_NUM="$OPTARG" ;;
        m) MODE="$OPTARG" ;;
        s) TARGET_MONITOR="$OPTARG" ;;
        d) DRY_RUN=true ;;
        h) usage ;;
        *) usage ;;
      esac
    done

    # --- Discovery ---
    get_monitors() { hyprctl monitors all -j | jq -c '.'; }
    get_active_monitors() { hyprctl monitors -j | jq -c '.'; }

    # Identify primary (eDP)
    MONITORS_JSON=$(get_monitors)
    PRIMARY=$(echo "$MONITORS_JSON" | jq -r '.[] | select(.name | test("eDP-[0-9]+")) | .name' | head -n 1)
    [ -z "$PRIMARY" ] && warn "Could not detect primary eDP monitor"

    find_external() {
      local json="$1"
      if [ -n "$TARGET_MONITOR" ]; then
        echo "$json" | jq -r ".[] | select(.name == \"$TARGET_MONITOR\") | .name"
      else
        # Pick the first non-eDP monitor
        echo "$json" | jq -r '.[] | select(.name | test("eDP-[0-9]+") | not) | .name' | head -n 1
      fi
    }

    # Retry loop for hotplug
    EXTERNAL=""
    for i in $(seq 1 $RETRY_COUNT); do
      EXTERNAL=$(find_external "$(get_monitors)")
      if [ -n "$EXTERNAL" ] && [ "$EXTERNAL" != "null" ]; then
        break
      fi
      log "Waiting for external monitor detection (attempt $i/$RETRY_COUNT)..."
      sleep "$RETRY_DELAY"
    done

    # --- Action Logic ---
    if [ "$MODE" = "off" ] || [ -z "$EXTERNAL" ] || [ "$EXTERNAL" = "null" ]; then
      if [ "$MODE" = "off" ] && [ -n "$EXTERNAL" ] && [ "$EXTERNAL" != "null" ]; then
        log "Disabling monitor: $EXTERNAL"
        run_hyprctl keyword monitor "$EXTERNAL, disable"
      fi
      
      log "Ensuring workspace $WORKSPACE_NUM is on primary: $PRIMARY"
      run_hyprctl dispatch moveworkspacetomonitor "$WORKSPACE_NUM" "$PRIMARY"
      exit 0
    fi

    log "Targeting external monitor: $EXTERNAL (Mode: $MODE)"

    # State Awareness: Check if monitor is already active
    IS_ACTIVE=$(get_active_monitors | jq -r ".[] | select(.name == \"$EXTERNAL\") | .name")
    
    case "$MODE" in
      mirror)
        run_hyprctl keyword monitor "$EXTERNAL, preferred, auto, 1, mirror, $PRIMARY"
        ;;
      extend)
        # Only re-enable if not active or if we want to force preferred settings
        run_hyprctl keyword monitor "$EXTERNAL, preferred, auto, 1"
        ;;
      *) error "Invalid mode: $MODE" ;;
    esac

    # State Awareness: Check workspace location
    CURRENT_MONITOR=$(hyprctl workspaces -j | jq -r ".[] | select(.id == $WORKSPACE_NUM) | .monitor" || echo "")
    if [ "$CURRENT_MONITOR" != "$EXTERNAL" ]; then
      log "Moving workspace $WORKSPACE_NUM to $EXTERNAL"
      run_hyprctl dispatch moveworkspacetomonitor "$WORKSPACE_NUM" "$EXTERNAL"
    else
      log "Workspace $WORKSPACE_NUM is already on $EXTERNAL"
    fi

    # Final Focus
    run_hyprctl dispatch focusmonitor "$EXTERNAL"
    run_hyprctl dispatch workspace "$WORKSPACE_NUM"

    log "[+] Setup complete!"
  '';
in
{
  imports = [
    ../wayland
    ./polkit.nix
    ./stylix.nix
  ];

  services.hyprsunset = {
    enable = true;
    settings = {
      max-gamma = 150;
      profile = [
        {
          # Daytime — neutral color temperature
          time = "07:30";
          temperature = 6500;
          gamma = 1.0;
        }
        {
          # Night — warm temperature to reduce eye strain
          time = "21:00";
          temperature = 4000;
          gamma = 0.9;
        }
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        # Use loginctl to trigger lock_cmd reliably before sleep
        before_sleep_cmd = "loginctl lock-session";
        # Turn display back on after resume
        after_sleep_cmd = "hyprctl dispatch dpms on";
        # Prevent duplicate hyprlock instances via pidof check
        lock_cmd = "pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
      };
      listener = [
        {
          # Lock session after 5 minutes — fires lock_cmd above
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          # Turn displays off 30s after locking — gives hyprlock
          # time to fully initialize before blanking the screen
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          # Suspend after 30 minutes of total inactivity
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
        # Render immediately — no waiting for resources
        immediate_render = true;
      };

      auth = {
        # Standard PAM authentication
        "pam:enabled" = true;
        "pam:module" = "hyprlock";
        # Fingerprint disabled — not wanted
        "fingerprint:enabled" = false;
      };

      animations = {
        # Disable all animations — instant transitions
        enabled = false;
      };

      background = [
        {
          monitor = "";
          # Solid Kanagawa sumiInk0 — no image, no blur
          color = "rgba(16161Dff)";
          blur_passes = 0;
        }
      ];

      label = [
        {
          # Clock — dominant element, warm fujiWhite
          monitor = "";
          # $TIME built-in — more efficient than shell command
          text = "$TIME";
          color = "rgba(C8C093ff)";
          font_size = 120;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 160";
          halign = "center";
          valign = "center";
        }
        {
          # Date — muted fujiGray, secondary hierarchy
          monitor = "";
          # Update every minute — no need for per-second refresh
          text = ''cmd[update:60000] echo "$(date +"%A, %d %B %Y")"'';
          color = "rgba(727169ff)";
          font_size = 13;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 60";
          halign = "center";
          valign = "center";
        }
        {
          # Retro prompt — sumiInk4, intentionally barely visible
          monitor = "";
          text = "ENTER PASSWORD";
          color = "rgba(54546Dff)";
          font_size = 9;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, -100";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "280, 36";
          # Sharp corners — terminal aesthetic, no rounding
          rounding = 0;
          outline_thickness = 1;
          inner_color = "rgba(1F1F2800)";
          outer_color = "rgba(54546Dff)";  # sumiInk4 — idle border
          check_color = "rgba(7E9CD8ff)";  # crystalBlue — verifying
          fail_color = "rgba(C4746Eff)";   # autumnRed — wrong password
          font_color = "rgba(C8C093ff)";   # fujiWhite — typed text
          font_family = "JetBrainsMono Nerd Font";
          # Dashes instead of dots — retro terminal feel
          dots_text_format = "-";
          dots_size = 0.3;
          dots_spacing = 0.2;
          fade_on_empty = false;
          placeholder_text = "";
          fail_text = "[ $ATTEMPTS failed attempts ]";
          position = "0, -140";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  home.packages = with pkgs; [
    projector
    wbg
    nwg-displays
    pavucontrol
    xdg-desktop-portal-hyprland
    jq # clipboard json parsing for dunst/fuzzel menu
    brave
    librewolf
    obsidian
    anki
    libreoffice-fresh
  ];

  xdg.configFile = {
    "hypr/hyprland.conf".source = ../../../dotfiles/hyprland/.config/hypr/hyprland.conf;
    "hypr/startup.conf".source = ../../../dotfiles/hyprland/.config/hypr/startup.conf;
    "hypr/scripts/random-wallpaper" = {
      source = ../../../dotfiles/hyprland/.config/hypr/scripts/random-wallpaper.sh;
      executable = true;
    };
    "hypr/scripts/audio" = {
      source = ../../../dotfiles/hyprland/.config/hypr/scripts/audio.sh;
      executable = true;
    };
    "hypr/scripts/brightness" = {
      source = ../../../dotfiles/hyprland/.config/hypr/scripts/brightness.sh;
      executable = true;
    };
  };
}
