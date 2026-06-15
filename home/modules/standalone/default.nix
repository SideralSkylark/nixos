{ pkgs, ... }:
{
  imports = [
    ./shell.nix
    ../hyprland/scripts.nix
    ../hyprland/swappy.nix
    ../wayland
  ];
  wayland.manageWaybarPackage = true;
  wayland.manageKittyPackage = false;
  wayland.manageBrightnessctl = false;
  wayland.manageClipboard = false;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    wbg # Wallpaper setter for Wayland
    nwg-displays # GUI for monitor configuration
    pavucontrol # PulseAudio volume control (GUI)
    jq
    nodejs_24
    jdk25
    google-java-format
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    lazydocker # TUI for docker
    lazygit # TUI for git
    bruno # Open-source API client
  ];

  xdg.configFile = {
    "hypr/hyprland.lua".source = ../../../dotfiles/hyprland/.config/hypr/hyprland.lua;
    "hypr/startup.lua".source = ../../../dotfiles/hyprland/.config/hypr/startup.lua;
    "hypr/hypridle.conf" = {
      source = ../../../dotfiles/hyprland/.config/hypr/hypridle.conf;
    };
    "hypr/hyprlock.conf" = {
      source = ../../../dotfiles/hyprland/.config/hypr/hyprlock.conf;
    };
    "hypr/hyprsunset.conf" = {
      source = ../../../dotfiles/hyprland/.config/hypr/hyprsunset.conf;
    };
  };
}
