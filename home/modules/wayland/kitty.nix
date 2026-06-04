{
  lib,
  config,
  pkgs,
  ...
}:
{
  xdg.configFile."kitty/kitty.conf".source = ../../../dotfiles/kitty/.config/kitty/kitty.conf;

  home.packages = lib.mkIf config.wayland.manageKittyPackage [ pkgs.kitty ];
}
