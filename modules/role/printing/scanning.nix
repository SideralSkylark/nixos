{ pkgs, ... }:
{
  hardware.sane = {
    enable = true;
    extraBackends = [
      pkgs.hplip        # HP multifunction
      pkgs.epkowa       # Epson multifunction
    ];
  };

  services.udev.packages = [ pkgs.sane-backends ];

  environment.systemPackages = with pkgs; [
    kdePackages.skanlite # Image scanning application
  ];

  users.groups.scanner = { };
  users.groups.lp = { };
}
