{ pkgs, ... }:

{
    # Disable login as root
    users.users.root.hashedPassword = "!";

    security.sudo.enable = true;

    #### shh protection ####
    services.fail2ban = {
        enable = true;
    };

    security.polkit.enable = true;

}

