{ config, pkgs, ... }:

{
  home.username = "skylark";
  home.homeDirectory = "/home/skylark";
  home.stateVersion = "26.05";

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
    "fastfetch/config.jsonc".source = ../dotfiles/fastfetch/.config/fastfetch/config.jsonc;
    "starship/starship.toml".source = ../dotfiles/starship/.conf/starship.toml;
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "Skylark";
      user.email = "152505167+SideralSkylark@users.noreply.github.com";
      core.editor = "nvim";
    };
  };

  home.packages = with pkgs; [
    vim # Text editor (fallback)
    fastfetch # System information fetcher
    btop # Resource monitor
    ripgrep # High-performance search tool
    fd # Simple and fast alternative to 'find'
    fzf # Command-line fuzzy finder
    curl # Transfer data with URLs
    wget # Retrieve files from the web
    zip # Archive utility
    unzip # Unzip utility
    p7zip # 7z compression utility
    unrar # RAR archive extractor
    man-pages # Linux manual pages
  ];

  programs.bash = {
    enable = true;
    sessionVariables = {
      VISUAL = "nvim";
      EDITOR = "nvim";
    };
  };

  programs.starship.enable = true;

  programs.zoxide.enable = true;
}
