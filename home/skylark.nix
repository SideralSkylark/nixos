{ config, ... }:

{
  home.username = "skylark";
  home.homeDirectory = "/home/skylark";
  home.stateVersion = "26.05";

  imports = [
    ./modules
  ];

  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      setSessionVariables = true;
      createDirectories = true;

      download = "${config.home.homeDirectory}/Downloads";
      documents = "${config.home.homeDirectory}/Documents";
      pictures = "${config.home.homeDirectory}/Pictures";
      videos = "${config.home.homeDirectory}/Videos";
      projects = "${config.home.homeDirectory}/Projects";

      desktop = null;
      music = null;
      publicShare = null;
      templates = null;
    };
  };

  xdg.configFile = {
    # fastfetch
    "fastfetch/config.jsonc".source = ../dotfiles/fastfetch/.config/fastfetch/config.jsonc;

    # Starship
    "starship/starship.toml".source = ../dotfiles/starship/.conf/starship.toml;
  };
}
