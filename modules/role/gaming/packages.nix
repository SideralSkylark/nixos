{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    hydralauncher
    heroic
    lutris
    bottles
    wineWowPackages.full  # keep full for max compat across launchers
    winetricks
    protonup-qt
  ];
}
