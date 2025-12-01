{
    services.dbus.enable = true;

    security.polkit.enable = true;

    services.udev.enable = true;

    services.xserver.enable = false;

    services.displayManager.gdm.enable = true;
    services.displayManager.gdm.wayland = true;

    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };
}
