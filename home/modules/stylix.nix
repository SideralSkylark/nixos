{ pkgs, ... }:
{
    stylix.targets = {
        gtk.enable = true;
        qt.enable = true;
        hyprland.enable = true;
        kitty.enable = false;
    };

    gtk.enable = true;
    qt.enable = true;
}
