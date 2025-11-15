{ config, lib, pkgs, ... }:

{
  imports = [
        #./boot.nix
    ./gc.nix
    ./networking.nix
    ./timezone.nix
    ./nix.nix
    ./packages.nix
    ./fonts.nix
    #./users.nix
  ];
}
