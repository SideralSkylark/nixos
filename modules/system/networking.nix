{ ... }:
{
  networking.wireless.iwd = {
    enable = true;
    settings = {
      General = {
        EnableNetworkConfiguration = true;
        AddressRandomization = "network"; 
      };
      Station.RoamingEnabled = true;
    };
  };

  networking.useNetworkd = true;
  networking.useDHCP = false;
  systemd.network = {
    enable = true;
    networks."10-ethernet" = {
      matchConfig.Type = "ether";
      networkConfig.DHCP = "yes";
      dhcpV4Config.RouteMetric = 100; #perfer ethernet over wifi
    };
  };

  networking.networkmanager.enable = false;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
  };
}
