{ pkgs, ... }:

{
    imports = [
       ./packages.nix 
    ];

    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;

    extraPackages = with pkgs; [
        mesa_drivers
        vulkan-loader
        vulkan-validation-layers
        vaapiVdpau
        libvdpau-va-gl
    ];

    extraPackages32 = with pkgs; [
        mesa_drivers
        vulkan-loader
    ];
  };

  # --- Steam ---
    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
    };

}
