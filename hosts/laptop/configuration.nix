{
  imports = [
    ../../modules
    ../../modules/role/dev
    ../../modules/role/hyprland
    ../../modules/role/bluetooth
    # ../../modules/role/printing
    ./boot.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "laptop";
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
