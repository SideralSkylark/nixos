{ lib, ... }:
{
  imports = [
    ./dunst.nix
    ./packages.nix
    ./foot.nix
    ./fuzzel.nix
    ./mpv.nix
    ./waybar.nix
  ];

  options.wayland = {
    manageFootPackage = lib.mkEnableOption "Install foot via Nix";
    manageWaybarPackage = lib.mkEnableOption "Install waybar via Nix";
  };
}
