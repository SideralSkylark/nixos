{ config, lib, pkgs, ... }:

{
 imports = [
  ./hardware-configuration.nix
  ../../modules
 ];

 networking.hostName = "nixos";
 system.stateVersion = "25.11";

 users.users.skylark = {
  isNormalUser = true;
  extraGroups = ["wheel" "audio" "video" "docker" ];
 };
}

