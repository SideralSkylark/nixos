{ pkgs, ... }:
{
  imports = [ ./packages.nix ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver   # Intel VA-API (iGPU hardware decode)
      libva-vdpau-driver   # keep for Intel VDPAU compat
    ];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  programs.gamemode.enable = true;
}
