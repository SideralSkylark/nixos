{config, pkgs, ... }:
{
    stylix.targets = {
        gtk.enable = true;
        qt.enable = true;
        hyprland.enable = true;
        kitty.enable = false;
    };

    gtk = {
        enable = true;
        iconTheme = {
            package = pkgs.papirus-icon-theme;
            name = "Papirus-Dark";
        };
    };

    qt.enable = true;
}
