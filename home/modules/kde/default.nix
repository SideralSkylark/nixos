{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vscode
    lazydocker
    lazygit
    postman
    jdk21_headless
    nodejs_22
    rustc
    cargo
  ];
}
