{
  imports = [
    ../../modules
    ../../modules/role/dev
    ../../modules/role/hyprland
    ../../modules/role/bluetooth
    ../../modules/role/printing
    # ../../modules/role/gaming
    ./hardware-configuration.nix
  ];

  networking.hostName = "laptop";
  system.stateVersion = "25.11";

  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  users.users.skylark = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
      "video"
      "lpadmin"
      "scanner"
      "networkmanager"
      "docker"
    ];
  };
}
