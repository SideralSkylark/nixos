{
  virtualisation.docker = {
    enable = true; # enable Docker service
    enableOnBoot = false; # do not start automatically on boot
  };

  users.groups.docker = { };
}
