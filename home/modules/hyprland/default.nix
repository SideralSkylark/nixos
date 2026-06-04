{
  imports = [
    ../wayland
    ./packages.nix
    ./services.nix
    ./hyprlock.nix
  ];

  wayland.manageKittyPackage = true;
  wayland.manageWaybarPackage = true;
  wayland.manageBrightnessctl = true;
  wayland.manageClipboard = true;

  stylix.targets = {
    dunst.enable = false;
    gtk.enable = true;
    gtk.colors.enable = true;
    qt.enable = true;
    hyprland.enable = true;
    kitty.enable = false;
    nixvim.enable = false;
    swaylock.enable = false;
    hyprlock.enable = false;
  };

  gtk.enable = true;
  qt.enable = true;
}
