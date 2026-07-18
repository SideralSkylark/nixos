{ pkgs, ... }:
{
  imports = [
    ./shell.nix
    ../hyprland/hyprland-base.nix
    ../hyprland/scripts.nix
    ../hyprland/swappy.nix
    ../wayland
  ];
  wayland.manageWaybarPackage = true;
  wayland.manageFootPackage = false;
  wayland.manageBrightnessctl = false;
  wayland.manageClipboard = false;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    nodejs_24
    jdk25
    google-java-format
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    lazygit # TUI for git
    bruno # Open-source API client
  ];
}
