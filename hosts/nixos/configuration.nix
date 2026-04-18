{ pkgs, ... }: 
{
  imports = [
    ../../modules
    ../../modules/role/hyprland
    ./boot.nix
    ./hardware-configuration.nix
  ];

   environment.systemPackages = with pkgs; [
        gemini-cli
        nodejs_24
    ];

  networking.hostName = "nixos";
  system.stateVersion = "25.11";

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
