{ config, pkgs, nixvim, zen-browser, ... }:

{
  home.username = "skylark";
  home.homeDirectory = "/home/skylark";
  home.stateVersion = "25.05";

  imports = [
    ./modules
    nixvim.homeModules.nixvim
  ];

  home.packages = [
    # ... pacotes existentes ...
    zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
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
    # Kitty
    "kitty/kitty.conf".source = ../dotfiles/kitty/.config/kitty/kitty.conf;
    "kitty/current-theme.conf".source = ../dotfiles/kitty/.config/kitty/current-theme.conf;

    # fastfetch
    "fastfetch/config.jsonc".source = ../dotfiles/fastfetch/.config/fastfetch/config.jsonc;

    # Starship
    "starship/starship.toml".source = ../dotfiles/starship/.conf/starship.toml;
  };
}
