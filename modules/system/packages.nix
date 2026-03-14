{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    usbutils
    parted
    gparted
    cups
    gcc
    python3
    iw # Network
    xdg-utils
    xdg-user-dirs
    libnotify
  ];
}
