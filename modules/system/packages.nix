{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    usbutils
    parted
    gparted
    iw # Network
    libnotify
  ];
}
