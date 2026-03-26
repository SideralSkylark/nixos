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
    imv # image viewer
    wl-clipboard
    cliphist

    waybar
    fuzzel
    # swaynotificationcenter
    # mako
    impala
    yazi
  ];
}
