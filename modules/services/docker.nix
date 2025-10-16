{ config, pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;          # enable Docker service
    enableOnBoot = false;   # do not start automatically on boot
  };
}
