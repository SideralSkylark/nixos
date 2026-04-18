{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kitty
    pamixer
    playerctl # Audio
    brightnessctl #backlight
    grim # screenshots
    slurp # screenshots
    swappy # screenshots
    imv # image viewer
    wl-clipboard
    cliphist
    waybar
    fuzzel
    impala
    yazi
  ];
}
