{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wbg # Wallpaper setter for Wayland
    nwg-displays # GUI for monitor configuration
    pavucontrol # PulseAudio volume control (GUI)
    jq # Command-line JSON processor
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
