{ pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        iw # Network
        bluez blueman # Bluethooh
        pamixer playerctl # Audio
        xdg-utils
        xdg-user-dirs
        gvfs
        udisks2
        libnotify
        polkit_gnome
        gdm
        brightnessctl
        xdg-desktop-portal-hyprland
        qt5.qtwayland
        qt6.qtwayland
        gtk3
    ];
}
