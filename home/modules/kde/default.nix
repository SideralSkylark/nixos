{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vscode
    lazydocker
    lazygit
    hoppscotch
    jdk21_headless
    nodejs_22
    rustc
    cargo
  ];
}
