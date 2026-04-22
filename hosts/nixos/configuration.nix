{ pkgs, ... }: 
{
  imports = [
    ../../modules
    ../../modules/role/hyprland
    ./boot.nix
    ./hardware-configuration.nix
  ];

   environment.systemPackages = with pkgs; [
        gemini-cli # Gemini AI CLI tool
        nodejs_24 # Node.js runtime (v24)
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
