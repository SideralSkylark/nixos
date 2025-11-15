{ config, pkgs, ... }:

{
    imports = [
        ./boot.nix
        ../common.nix
        ./hardware-configuration.nix
        ../../modules/role/dev
    ];

    networking.hostName = "laptop";
    system.stateVersion = "25.11";

    users.users.skylark = {
        isNormalUser = true;
        extraGroups = ["wheel" "audio" "video" "docker" "lpadmin"];
    };
}

