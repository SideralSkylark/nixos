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
		zed-editor
        lazydocker
        posting
        obsidian
        anki
    ];
}
