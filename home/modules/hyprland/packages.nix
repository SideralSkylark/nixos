{ pkgs, ... }:
let
  projector = pkgs.writeShellScriptBin "projector" ''
    #!/usr/bin/env bash
    set -euo pipefail

    # --- Defaults ---
    WORKSPACE_NUM="5"
    MODE="extend"        # extend | mirror | off
    TARGET_MONITOR=""    # Optional: specific monitor name
    SCALE="1"
    DRY_RUN=false
    RETRY_COUNT=5
    RETRY_DELAY=0.5

    # --- Helpers ---
    log()   { echo -e "[\033[1;34mINFO\033[0m] $*"; }
    warn()  { echo -e "[\033[1;33mWARN\033[0m] $*" >&2; }
    error() { echo -e "[\033[1;31mERROR\033[0m] $*" >&2; exit 1; }

    usage() {
      cat <<EOF
    Usage: $(basename "$0") [options]
    Options:
      -w <num>    Workspace number (default: $WORKSPACE_NUM)
      -m <mode>   Mode: extend (default), mirror, off
      -s <name>   Specific monitor name to target
      -k <scale>  Output scale (default: 1)
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
    while getopts "w:m:s:k:dh" opt; do
      case "$opt" in
        w) WORKSPACE_NUM="$OPTARG" ;;
        m) MODE="$OPTARG" ;;
        s) TARGET_MONITOR="$OPTARG" ;;
        k) SCALE="$OPTARG" ;;
        d) DRY_RUN=true ;;
        h) usage ;;
        *) usage ;;
      esac
    done

    # --- Early Validation ---
    [[ "$WORKSPACE_NUM" =~ ^[0-9]+$ ]] || error "Workspace number must be a positive integer"
    case "$MODE" in
      extend|mirror|off) ;;
      *) error "Invalid mode: '$MODE'. Must be one of: extend, mirror, off" ;;
    esac

    # --- Discovery ---
    get_monitors()        { hyprctl monitors all -j | jq -c '.'; }
    get_active_monitors() { hyprctl monitors -j     | jq -c '.'; }

    # Identify primary (eDP)
    MONITORS_JSON=$(get_monitors)
    PRIMARY=$(echo "$MONITORS_JSON" | jq -r '.[] | select(.name | test("eDP-[0-9]+")) | .name' | head -n 1)
    [ -z "$PRIMARY" ] && warn "Could not detect primary eDP monitor"

    find_external() {
      local json="$1"
      if [ -n "$TARGET_MONITOR" ]; then
        echo "$json" | jq -r ".[] | select(.name == \"$TARGET_MONITOR\") | .name"
      else
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

    log "Targeting external monitor: $EXTERNAL (Mode: $MODE, Scale: $SCALE)"

    # State awareness: check if monitor is already active
    IS_ACTIVE=$(get_active_monitors | jq -r ".[] | select(.name == \"$EXTERNAL\") | .name")

    case "$MODE" in
      mirror)
        # Move workspace back to primary first — prevents it becoming orphaned
        # when the external monitor loses its independent display in mirror mode
        log "Returning workspace $WORKSPACE_NUM to primary before mirroring"
        run_hyprctl dispatch moveworkspacetomonitor "$WORKSPACE_NUM" "$PRIMARY"
        run_hyprctl keyword monitor "$EXTERNAL, preferred, auto, $SCALE, mirror, $PRIMARY"
        # Switch primary to the workspace so the TV mirrors it immediately
        run_hyprctl dispatch workspace "$WORKSPACE_NUM"
        ;;
      extend)
        # Only re-enable if not already active to avoid unnecessary re-layout flicker
        if [ -z "$IS_ACTIVE" ]; then
          run_hyprctl keyword monitor "$EXTERNAL, preferred, auto, $SCALE"
        fi

        # Move workspace to external if not already there
        CURRENT_MONITOR=$(hyprctl workspaces -j | jq -r ".[] | select(.id == $WORKSPACE_NUM) | .monitor // empty" 2>/dev/null) || CURRENT_MONITOR=""
        if [ "$CURRENT_MONITOR" != "$EXTERNAL" ]; then
          log "Moving workspace $WORKSPACE_NUM to $EXTERNAL"
          run_hyprctl dispatch moveworkspacetomonitor "$WORKSPACE_NUM" "$EXTERNAL"
        else
          log "Workspace $WORKSPACE_NUM is already on $EXTERNAL"
        fi

        run_hyprctl dispatch focusmonitor "$EXTERNAL"
        run_hyprctl dispatch workspace "$WORKSPACE_NUM"
        ;;
    esac

    log "[+] Setup complete!"
  '';

  screenshot = pkgs.writeShellScriptBin "screenshot" ''
    DIR="$HOME/Pictures/screenshots"
    NAME="screenshot_$(date +%F_%T).png"
    FILE="$DIR/$NAME"
    TMP_FILE="/tmp/screenshot_pending.png"

    mkdir -p "$DIR"

    notify_view() {
        ${pkgs.libnotify}/bin/notify-send \
            -a "system" \
            -u low \
            -t 3000 \
            -i "$1" \
            "Screenshot Captured" "Saved to $DIR"
    }

    case $1 in
        edit)
            SEL=$(${pkgs.slurp}/bin/slurp)
            if [ -z "$SEL" ]; then
                exit 0
            fi

            ${pkgs.grim}/bin/grim -g "$SEL" "$TMP_FILE"
            ${pkgs.swappy}/bin/swappy -f "$TMP_FILE" -o "$FILE"

            if [ -f "$FILE" ]; then
                ${pkgs.wl-clipboard}/bin/wl-copy < "$FILE"
                notify_view "$FILE"
                rm -f "$TMP_FILE"
            fi
            ;;
        screen)
            ${pkgs.grim}/bin/grim "$FILE"
            if [ -f "$FILE" ]; then
                ${pkgs.wl-clipboard}/bin/wl-copy < "$FILE"
                notify_view "$FILE"
            fi
            ;;
        *)
            echo "Usage: screenshot {edit|screen}"
            exit 1
            ;;
    esac
  '';
in
{
  home.packages = with pkgs; [
    projector # Custom script for monitor management
    screenshot # Custom script for taking screenshots
    wbg # Wallpaper setter for Wayland
    nwg-displays # GUI for monitor configuration
    pavucontrol # PulseAudio volume control (GUI)
    xdg-desktop-portal-hyprland # Hyprland-specific XDG portal
    jq # Command-line JSON processor
    brave # Web browser
    librewolf # Privacy-focused web browser
    obsidian # Markdown-based knowledge base
    anki # Flashcard application
    libreoffice-fresh # Productivity suite (fresh version)
  ];

  programs.swappy = {
    enable = true;
    settings = {
      config = {
        save_dir = "$HOME/Pictures/screenshots";
        save_filename_format = "screenshot_%Y%m%d_%H%M%S.png";
        show_panel = false;
        line_size = 5;
        text_size = 20;
        text_font = "sans-serif";
        paint_mode = "brush";
        early_exit = true;
        fill_shape = false;
      };
    };
  };

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
