{
  programs.bat = {
    enable = true;
    config = {
      paging = "never";
      style = "numbers";
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      kn = "~/.local/bin/kn";
    };
  };

  programs.starship.enable = true;

  programs.zoxide.enable = true;
}
