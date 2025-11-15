{ config, pkgs, ... }:

{
    imports = [
        ./boot.nix
        ./hardware-configuration.nix
        ../common.nix
    ];

    networking.hostName = "laptop";
    system.stateVersion = "25.11";

    users.users.skylark = {
        isNormalUser = true;
        extraGroups = ["wheel" "audio" "video" "docker" "lpadmin"];
    };
}

