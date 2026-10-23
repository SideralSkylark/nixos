{ pkgs, ... }:
{
  services.printing = {
    enable = true;
    drivers = [
      pkgs.hplip
      pkgs.epson-escpr
    ];
  };

  # Network printer and scanner discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  hardware.sane = {
    enable = true;
    extraBackends = [
      pkgs.hplip
      pkgs.epkowa
      pkgs.sane-airscan
    ];
  };

  services.udev.packages = [
    pkgs.sane-backends
    pkgs.sane-airscan
  ];

  environment.systemPackages = with pkgs; [
    system-config-printer
    simple-scan
    sane-airscan
  ];
}
