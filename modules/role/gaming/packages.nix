{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        hydralauncher
        heroic
        lutris
        bottles
        wineWowPackages.full
        winetricks
        protonup-qt
    ]; 
}
