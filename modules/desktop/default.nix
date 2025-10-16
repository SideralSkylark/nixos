{ config, pkgs, ... }:
{
  imports = [
    ./packages.nix
    ./session.nix
    ./stylix.nix
  ];
}
