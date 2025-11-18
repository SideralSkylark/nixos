{ config, pkgs, ... }:

{
    services.dbus.enable = true;

    security.polkit.enable = true;

    services.udev.enable = true;

    services.xserver.enable = true;

    services.xserver.displayManager.gdm.enable = true;
    services.xserver.displayManager.gdm.wayland = true;

    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };
}
