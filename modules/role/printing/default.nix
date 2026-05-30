{ pkgs, ... }:
{
  services.printing = {
    enable = true;
    drivers = [
      pkgs.hplip
      pkgs.epson-escpr
    ];
  };

  hardware.sane = {
    enable = true;
    extraBackends = [
      pkgs.hplip # HP multifunction
      pkgs.epkowa # Epson multifunction
    ];
  };

  services.udev.packages = [ pkgs.sane-backends ];

  environment.systemPackages = with pkgs; [
    kdePackages.skanlite # scanning frontend
  ];

  users.groups.scanner = { };
  users.groups.lp = { };
  users.groups.lpadmin = { };
}
