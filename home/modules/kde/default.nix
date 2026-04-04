{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vscode
    lazydocker
    lazygit
    bruno #api tests
    jdk21_headless
    nodejs_22
    rustc
    cargo
  ];
}
