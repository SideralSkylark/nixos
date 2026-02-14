{ pkgs, ... }:

{
    imports = [
       ./packages.nix 
    ];

    hardware.graphics = {
        enable = true;
        enable32Bit = true;

        extraPackages = with pkgs; [
            mesa
            vulkan-loader
            vulkan-validation-layers
            libva-vdpau-driver
            libvdpau-va-gl
        ];
    };

    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
    };

    programs.gamemode.enable = true;
}

