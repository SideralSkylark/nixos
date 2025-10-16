{ config, pkgs, ... }:

{
 users.users.skylark = {
  isNormalUser = true;
  extraGroups = ["wheel" "audio" "video"]; #video -> brightnessctl
  packages = with pkgs; [
   tree
  ];
 };
}
