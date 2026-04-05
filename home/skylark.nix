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
    imports = [ ./modules/nixvim ];
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
    # fastfetch
    "fastfetch/config.jsonc".source = ../dotfiles/fastfetch/.config/fastfetch/config.jsonc;

    # Starship
    "starship/starship.toml".source = ../dotfiles/starship/.conf/starship.toml;
  };
}
