{
  imports = [
    ./wayland/mpv.nix
  ];

  xdg.configFile = {
    "hypr/hyprland.lua".source = ../../dotfiles/hyprland/.config/hypr/hyprland.lua;
    "hypr/startup.lua".source = ../../dotfiles/hyprland/.config/hypr/startup.lua;
    "ghostty/config.ghostty".source = ../../dotfiles/ghostty/config.ghostty;
  };
}
