{ config, pkgs, nixvim, ... }:

{
  home.username = "skylark";
  home.homeDirectory = "/home/skylark";
  home.stateVersion = "25.05";

  imports = [
    ./modules    # any home-manager modules you define later
    nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    imports = [ ./modules/nixvim.nix ];
  };


  xdg.configFile = {
    # Hyprland
    "hypr/hyprland.conf".source = ../dotfiles/hyprland/.config/hypr/hyprland.conf;
    "hypr/startup.conf".source  = ../dotfiles/hyprland/.config/hypr/startup.conf;
    "hypr/scripts/random-wallpaper" = {
      source = ../dotfiles/hyprland/.config/hypr/scripts/random-wallpaper.sh;
      executable = true;
    };

    # Hyprlock
    "hypr/hyprlock.conf".source = ../dotfiles/hyprlock/.config/hypr/hyprlock.conf;

    # Hyprsunset
    "hypr/hyprsunset.conf".source = ../dotfiles/hyprsunset/.config/hypr/hyprsunset.conf;

    # Kitty
    "kitty/kitty.conf".source = ../dotfiles/kitty/.config/kitty/kitty.conf;
    "kitty/current-theme.conf".source = ../dotfiles/kitty/.config/kitty/current-theme.conf;

    # fastfetch
    "fastfetch/config.jsonc".source = ../dotfiles/fastfetch/.config/fastfetch/config.jsonc;

    # Starship
    "starship/starship.toml".source = ../dotfiles/starship/.conf/starship.toml;

    # SwayNC
    "swaync/config.json".source = ../dotfiles/swaync/.config/swaync/config.json;
    "swaync/style.css".source = ../dotfiles/swaync/.config/swaync/style.css;
    "swaync/icons".source = ../dotfiles/swaync/.config/swaync/icons;
    "swaync/themes".source = ../dotfiles/swaync/.config/swaync/themes;

    # Waybar
    "waybar/config.jsonc".source = ../dotfiles/waybar/.config/waybar/config.jsonc;
    "waybar/style.css".source    = ../dotfiles/waybar/.config/waybar/style.css;
    "waybar/scripts".source      = ../dotfiles/waybar/.config/waybar/scripts;

    # Wofi
    "wofi/wofi.conf".source = ../dotfiles/wofi/.config/wofi/wofi.conf;
    "wofi/style.css".source = ../dotfiles/wofi/.config/wofi/style.css;
  };
}

