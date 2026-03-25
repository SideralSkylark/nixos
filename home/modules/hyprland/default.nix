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
    wlsunset
    xdg-desktop-portal-hyprland
    brave
    librewolf
    vlc
    obsidian
    anki
    simple-scan
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

    "swaylock/config".text = ''
      # Background
      screenshot
      effect-pixelate=12
      effect-vignette=0.3:0.7

      # Colors — Kanagawa
      color=1F1F28ee
      inside-color=2A2A3700
      inside-clear-color=2A2A3700
      inside-ver-color=16161D00
      inside-wrong-color=43242B00

      ring-color=7AA89F
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
      indicator-radius=70
      indicator-thickness=4

      # Font
      font=JetBrainsMono Nerd Font
      font-size=14

      # Clock
      clock
      timestr=%H:%M
      datestr=%a, %d %b
      indicator

      # Caps lock
      ring-caps-lock-color=E6C384
      inside-caps-lock-color=2A2A3700
      text-caps-lock-color=E6C384
      indicator-caps-lock

      # Misc
      ignore-empty-password
      show-failed-attempts
    '';
  };
}
