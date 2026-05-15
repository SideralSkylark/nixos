{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    hydralauncher # Game launcher
    heroic # Epic, GOG, and Amazon Games launcher
    lutris # Open gaming platform for Linux
    bottles # Run Windows software on Linux
    wineWowPackages.full # WINE with full compatibility
    winetricks # Helper script for WINE
    protonup-qt # Manage Proton-GE and Luxtorpeda versions
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver # Intel VA-API (iGPU hardware decode)
      libva-vdpau-driver # keep for Intel VDPAU compat
    ];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  programs.gamemode.enable = true;
}
