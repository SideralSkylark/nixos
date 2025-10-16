{ config, pkgs, ... }:

{
   imports = [
      ./audio.nix
      ./bluetooth.nix
      ./docker.nix
      ./power.nix
      ./printing.nix
      ./ssh.nix
      ./storage.nix
   ];
}
