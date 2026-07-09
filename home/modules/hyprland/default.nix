{
  imports = [
    ../wayland
    ./packages.nix
    ./scripts.nix
    ./services.nix
    ./swappy.nix
    ./hyprlock.nix
  ];

  wayland.manageFootPackage = true;
  wayland.manageWaybarPackage = true;
  wayland.manageBrightnessctl = true;
  wayland.manageClipboard = true;

  stylix.targets = {
    dunst.enable = false;
    gtk.enable = true;
    gtk.colors.enable = true;
    qt.enable = true;
    hyprland.enable = true;
    foot.enable = false;
    nixvim.enable = false;
    swaylock.enable = false;
    hyprlock.enable = false;
    fuzzel.enable = false;
  };

  gtk.enable = true;
  qt.enable = true;
}
