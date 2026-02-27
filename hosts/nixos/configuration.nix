{
  imports = [
    ./boot.nix
    ./hardware-configuration.nix
    ../../modules/role/dev
    ../common.nix
  ];

  networking.hostName = "nixos";
  system.stateVersion = "25.11";

  users.users.skylark = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
      "video"
      "docker"
      "lpadmin"
    ];
  };
}
