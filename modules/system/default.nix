{ pkgs, lib, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    fontconfig.enable = true;
    packages = with pkgs; [
      noto-fonts-cjk-sans # Google Noto Sans CJK fonts
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
    networkmanagerapplet
    libnotify # Desktop notifications library
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

  stylix = {
    enable = true;
    image = null;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.roboto;
        name = "Roboto";
      };
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 12;
        terminal = 14;
        desktop = 12;
        popups = 11;
      };
    };
    opacity = {
      applications = 1.0;
      terminal = 1.0;
      desktop = 1.0;
      popups = 1.0;
    };
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };
    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };
  };

  time.timeZone = "Africa/Maputo";
}
