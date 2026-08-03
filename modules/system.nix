{ pkgs, lib, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    fontconfig.enable = true;
    packages = with pkgs; [
      noto-fonts-cjk-sans # Google Noto Sans CJK fonts
      nerd-fonts.jetbrains-mono
      noto-fonts-color-emoji

    ];
  };

  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 2w";
  };

  networking.networkmanager.enable = true;

  networking.networkmanager.wifi = {
    powersave = true;
    macAddress = "stable-ssid";
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    usbutils # Tools for working with USB devices
    parted # Partitioning tool
    gparted # GUI partition manager
    libnotify
  ];

  # Disable login as root
  users.users.root.hashedPassword = "!";

  security.sudo.enable = true;

  #### shh protection ####
  services.sshguard = {
    enable = false;
  };

  security.polkit.enable = true;

  services.fprintd.enable = true;

  security.pam.services = {
    login.fprintAuth = lib.mkForce false;
    sudo.fprintAuth = lib.mkForce true;
    polkit-1.fprintAuth = lib.mkForce true;
    swaylock.fprintAuth = lib.mkForce false;
    hyprlock.fprintAuth = lib.mkForce false;
  };

  time.timeZone = "Africa/Maputo";
}
