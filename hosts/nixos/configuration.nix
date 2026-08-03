{ inputs, pkgs, ... }:
{
  imports = [
    ../../modules/services.nix
    ../../modules/system.nix.nix
    ../../modules/role/hyprland.nix
    ../../modules/role/gaming.nix
    ../../modules/role/dev.nix
    ./hardware-configuration.nix
    inputs.noctalia.nixosModules.default
  ];

  environment.systemPackages = with pkgs; [
    ghostty
    firefox
  ];

  networking.hostName = "nixos";
  system.stateVersion = "25.11";

  programs.noctalia = {
    enable = true;

    # Enables NetworkManager, Bluetooth, UPower, and a power profile service.
    recommendedServices.enable = true;
  };

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
