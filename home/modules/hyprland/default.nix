{ pkgs, ... }:
let
  projector = pkgs.writeShellScriptBin "projector" ''
    #!/usr/bin/env bash
    set -euo pipefail

    # Wait a moment for monitor detection and Hyprland socket readiness
    sleep 1

    # Look for the first monitor that is NOT the laptop display (eDP)
    EXTERNAL=$(hyprctl monitors -j | jq -r '.[] | select(.name | contains("eDP") | not) |.name' | head -n 1)

    if [ -z "$EXTERNAL" ] || [ "$EXTERNAL" == "null" ]; then
      echo "[!] No external monitor detected"
      exit 1
    fi

    echo "[>] Configuring monitor: $EXTERNAL"

    # 1. Enable the monitor (Preferred resolution, auto position, scale 1)
    hyprctl keyword monitor "$EXTERNAL, preferred, auto, 1"

    # 2. Move workspace 5 to the external monitor
    hyprctl dispatch moveworkspacetomonitor 5 "$EXTERNAL"

    # 3. Focus the new monitor and switch to workspace 5
    hyprctl dispatch focusmonitor "$EXTERNAL"
    hyprctl dispatch workspace 5

    echo "[+] Ready to present!"
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
