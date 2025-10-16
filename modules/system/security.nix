{ config, pkgs, lib, ... }:
{
  # Desativa login direto como root
  users.users.root.hashedPassword = "!";

  # Mantém sudo tradicional
  security.sudo.enable = true;

  #### Fail2ban (proteção SSH) ####
  services.fail2ban = {
    enable = true;
  };

  security.polkit.enable = true;

  #### ClamAV (antivírus) ####
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

  #### Firejail (sandbox para apps) ####
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
