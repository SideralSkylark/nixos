{
    networking.networkmanager.enable = true;
    networking.networkmanager.wifi.backend = "iwd";

    networking.networkmanager.wifi = {
        powersave = true;
        macAddress = "stable-ssid";  
    };

    networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 22 ];
        allowedUDPPorts = [ ];
    };
}

