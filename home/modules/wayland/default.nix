{ lib, ... }:
{
  imports = [
    ./dunst.nix
    ./packages.nix
    ./kitty.nix
    ./fuzzel.nix
    ./mpv.nix
    ./waybar.nix
  ];

  options.wayland = {
    manageKittyPackage = lib.mkEnableOption "Install kitty via Nix";
    manageWaybarPackage = lib.mkEnableOption "Install waybar via Nix";
  };
}
