{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kitty
    pamixer
    playerctl # Audio
    brightnessctl

    grim
    slurp
    swappy
    wl-clipboard
    cliphist

    waybar
    tofi
    swaynotificationcenter
    impala
    yazi
  ];
}
