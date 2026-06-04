{ lib, config, ... }:
{
  xdg.configFile."kitty/kitty.conf".source = ../../../dotfiles/kitty/.config/kitty/kitty.conf;

  programs.kitty.enable = lib.mkDefault config.wayland.manageKittyPackage;
}
