{
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
