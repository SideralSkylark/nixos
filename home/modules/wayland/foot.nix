{
  lib,
  config,
  pkgs,
  ...
}:
{
  xdg.configFile."foot/foot.ini".source = ../../../dotfiles/foot/.config/foot/foot.ini;

  home.packages = lib.mkIf config.wayland.manageFootPackage [ pkgs.foot ];
}
