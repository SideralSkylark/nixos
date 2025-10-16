{ config, pkgs, ... }:

{
  services.gvfs.enable = true; # both for thunar
  services.udisks2.enable = true;
}
