{
  imports = [
    ../../modules
    ../../modules/role/hyprland
    ../../modules/role/gaming
    ../../modules/role/dev
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixos";
  system.stateVersion = "25.11";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 2;

  users.users.skylark = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
      "video"
      "networkmanager"
    ];
  };
}
