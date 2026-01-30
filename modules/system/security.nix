{ lib, ... }:

{
    # Disable login as root
    users.users.root.hashedPassword = "!";

    security.sudo.enable = true;

    #### shh protection ####
    services.fail2ban = {
        enable = true;
    };

    security.polkit.enable = true;

    services.fprintd.enable = true;

    security.pam.services = {
        login.fprintAuth = lib.mkForce false;
        sudo.fprintAuth = lib.mkForce true;
        polkit-1.fprintAuth = lib.mkForce true;
    };
}

