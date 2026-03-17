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
    hyprlock
    hypridle
    hyprsunset
    xdg-desktop-portal-hyprland
    brave
    mpv
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

    # Hyprlock
    "hypr/hyprlock.conf".source = ../../../dotfiles/hyprlock/.config/hypr/hyprlock.conf;

    #Hypridle
    "hypr/hypridle.conf".source = ../../../dotfiles/hypridle/.config/hypr/hypridle.conf;

    # Hyprsunset
    "hypr/hyprsunset.conf".source = ../../../dotfiles/hyprsunset/.config/hypr/hyprsunset.conf;
  };
}
