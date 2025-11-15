{ config, lib, pkgs, ... }:

{
  imports = [
    ./gc.nix
    ./networking.nix
    ./timezone.nix
    ./nix.nix
    ./packages.nix
    ./fonts.nix
  ];
}
