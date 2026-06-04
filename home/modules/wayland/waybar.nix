{
  config,
  lib,
  pkgs,
  ...
}:
{
  xdg.configfile = {
    "waybar/config.jsonc".source = ../../../dotfiles/waybar/.config/waybar/config.jsonc;
    "waybar/style.css".source = ../../../dotfiles/waybar/.config/waybar/style.css;
    "waybar/scripts".source = ../../../dotfiles/waybar/.config/waybar/scripts;
  };

  home.packages = lib.mkIf config.wayland.mannageWaybarPackage [ pkgs.waybar ];
}
