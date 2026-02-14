{ config, nixvim, ... }:

{
  home.username = "skylark";
  home.homeDirectory = "/home/skylark";
  home.stateVersion = "25.05";

  imports = [
    ./modules   
    nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    imports = [ ./modules/nixvim.nix ];
  };

    xdg = {
    enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;

      download = "${config.home.homeDirectory}/Downloads";
      documents = "${config.home.homeDirectory}/Documents";
      pictures = "${config.home.homeDirectory}/Pictures";
      videos = "${config.home.homeDirectory}/Videos";

      # disable dirs you don't want
      desktop = null;
      music = null;
      publicShare = null;
      templates = null;

      extraConfig = {
        XDG_PROJECTS_DIR = "${config.home.homeDirectory}/Projects";
      };
    };
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

    #Hypridle
    "hypr/hypridle.conf".source = ../dotfiles/hypridle/.config/hypr/hypridle.conf;

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

    # Waybar
    "waybar/config.jsonc".source = ../dotfiles/waybar/.config/waybar/config.jsonc;
    "waybar/style.css".source    = ../dotfiles/waybar/.config/waybar/style.css;
    "waybar/scripts".source      = ../dotfiles/waybar/.config/waybar/scripts;

    # tofi
    "tofi/config".source = ../dotfiles/tofi/.config/tofi/config;
    "tofi/power.conf".source = ../dotfiles/tofi/.config/tofi/power.conf;
  };
}

