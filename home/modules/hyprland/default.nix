{ pkgs, ... }:
{
  imports = [
    ../wayland
    ./polkit.nix
    ./stylix.nix
  ];

  home.packages = with pkgs; [
    swww
    nwg-displays
    pavucontrol
    swaylock-effects
    swayidle
    hyprsunset
    xdg-desktop-portal-hyprland
    jq # parses json fron dunst to fuzzel menu
    brave
    librewolf
    obsidian
    anki
    libreoffice-fresh
  ];

  xdg.configFile = {
    # Hyprland
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

    "hypr/scripts/idle" = {
      source = ../../../dotfiles/hyprland/.config/hypr/scripts/idle.sh;
      executable = true;
    };

    # Hyprsunset configuration
    "hypr/hyprsunset.conf".text = ''
      max-gamma = 150

      # Profile for daytime (default)
      profile {
          time = 07:30
          temperature = 6500
          gamma = 1.0
      }

      # Profile for night
      profile {
          time = 21:00
          temperature = 4000
          gamma = 0.9
      }
    '';

    "swaylock/config".text = ''
      # Background
      color=16161D

      # Colors — Kanagawa
      inside-color=1F1F2800
      inside-clear-color=1F1F2800
      inside-ver-color=1F1F2800
      inside-wrong-color=43242B00
      ring-color=363646
      ring-clear-color=7AA89F
      ring-ver-color=7E9CD8
      ring-wrong-color=C4746E
      key-hl-color=98BB6C
      bs-hl-color=C4746E
      text-color=DCD7BA
      text-clear-color=C8C093
      text-ver-color=7E9CD8
      text-wrong-color=C4746E
      text-caps-lock-color=E6C384
      line-color=00000000
      line-clear-color=00000000
      line-ver-color=00000000
      line-wrong-color=00000000
      separator-color=00000000

      # Ring
      indicator-radius=80
      indicator-thickness=6

      # Font
      font=JetBrainsMono Nerd Font
      font-size=16

      # Clock
      clock
      timestr=%H:%M
      datestr=%a, %d %b
      indicator

      # Caps lock
      ring-caps-lock-color=E6C384
      inside-caps-lock-color=1F1F2800
      text-caps-lock-color=E6C384
      indicator-caps-lock

      # Misc
      ignore-empty-password
      show-failed-attempts
    '';
  };
}
