{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    usbutils # Tools for working with USB devices
    parted # Partitioning tool
    gparted # GUI partition manager
    iw # Tool for configuring wireless devices
    libnotify # Desktop notifications library
  ];
}
