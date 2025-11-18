{
    # Disable login as root
    users.users.root.hashedPassword = "!";

    security.sudo.enable = true;

    #### shh protection ####
    services.fail2ban = {
        enable = true;
    };

    security.polkit.enable = true;

  #### ClamAV ####
#   services.clamav = {
#     daemon.enable = true;
#     updater.enable = true;
#     updater.interval = "daily";
#     fangfrisch.enable = true;

#     scanner = {
#       enable = true;
#       interval = "Sat *-*-* 04:00:00";
#     };
#   };

  #### Firejail (sandbox) ####
#   programs.firejail = {
#     enable = true;
#     wrappedBinaries = {
#       brave = {
#         executable = "${lib.getBin pkgs.brave}/bin/brave";
#         profile = "${pkgs.firejail}/etc/firejail/brave.profile";
#       };
#     };
#   };
}

