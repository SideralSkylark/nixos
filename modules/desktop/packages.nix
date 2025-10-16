{ config, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        swaybg
        playerctl
        pamixer
        swww
    ];
}
