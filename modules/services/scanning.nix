{ pkgs, ... }:

{
    hardware.sane.enable = true;
    services.udev.packages = [ pkgs.sane-backends ];
    users.users.skylark.extraGroups = [ "scanner" ]; # add in the hosts config
}
