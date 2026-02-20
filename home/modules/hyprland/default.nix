{ pkgs, ... }:
{
  imports = [
    ./polkit.nix
    ./stylix.nix
  ];

  home.packages = with pkgs; [
    swww
    nwg-displays
    pavucontrol
    nautilus
    grim
    slurp
    swappy
    wl-clipboard
    cliphist
    swaybg
    waybar
    tofi
    swaynotificationcenter
    hyprlock
    hypridle
    hyprsunset
    btop
  ];

  xdg.configFile = {
    # Hyprland
    "hypr/hyprland.conf".source = ../../../dotfiles/hyprland/.config/hypr/hyprland.conf; 
    "hypr/startup.conf".source = ../../../dotfiles/hyprland/.config/hypr/startup.conf;
    "hypr/scripts/random-wallpaper" = {
      source = ../../../dotfiles/hyprland/.config/hypr/scripts/random-wallpaper.sh;
      executable = true;
    };

    # Hyprlock
    "hypr/hyprlock.conf".source = ../../../dotfiles/hyprlock/.config/hypr/hyprlock.conf;

    #Hypridle
    "hypr/hypridle.conf".source = ../../../dotfiles/hypridle/.config/hypr/hypridle.conf;

    # Hyprsunset
    "hypr/hyprsunset.conf".source = ../../../dotfiles/hyprsunset/.config/hypr/hyprsunset.conf;

    # SwayNC
    "swaync/config.json".source = ../../../dotfiles/swaync/.config/swaync/config.json;
    "swaync/style.css".source = ../../../dotfiles/swaync/.config/swaync/style.css;

    # Waybar
    "waybar/config.jsonc".source = ../../../dotfiles/waybar/.config/waybar/config.jsonc;
    "waybar/style.css".source = ../../../dotfiles/waybar/.config/waybar/style.css;
    "waybar/scripts".source = ../../../dotfiles/waybar/.config/waybar/scripts;

    # tofi
    "tofi/config".source = ../../../dotfiles/tofi/.config/tofi/config;
    "tofi/power.conf".source = ../../../dotfiles/tofi/.config/tofi/power.conf;
  };
}
