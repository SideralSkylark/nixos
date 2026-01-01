{ pkgs, ... }:
{
    home.packages = with pkgs; [
        kitty
        waybar
        wofi
        swaynotificationcenter
        starship
        hyprlock
        hypridle
        hyprsunset
        brave
        vlc
        obsidian
        anki
        tesseract # OCR(document validation)
    ];
}
