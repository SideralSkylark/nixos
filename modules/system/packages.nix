{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    usbutils # Tools for working with USB devices
    parted # Partitioning tool
    gparted # GUI partition manager
    networkmanagerapplet
    libnotify # Desktop notifications library
  ];
}
