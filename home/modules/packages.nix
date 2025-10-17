{config, pkgs, ... }:
{
    home.packages = with pkgs; [
        kitty
        waybar
        wofi
        swaynotificationcenter
        starship
        hyprlock
        hyprsunset
        brave
        vlc
        hydralauncher
        stow
        vscode
        lazydocker
        posting
        obsidian
        anki
    ];
}
