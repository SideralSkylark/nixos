{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kitty
    brave
    vlc
    obsidian
    anki
    fastfetch
    nitch
  ];
}
