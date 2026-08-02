{ pkgs, ... }:
{
  imports = [
    ./shell.nix
    ../wayland/mpv.nix
  ];

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

  xdg.configFile = {
    "hypr/hyprland.lua".source = ../../../dotfiles/hyprland/.config/hypr/hyprland.lua;
    "hypr/startup.lua".source = ../../../dotfiles/hyprland/.config/hypr/startup.lua;
    "ghostty/config.ghostty".source = ../../../dotfiles/ghostty/config.ghostty;
  };
}
