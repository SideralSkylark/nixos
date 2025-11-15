{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim 
    git
    man-pages
    htop
    fastfetch
    # Rede e drivers
    iw
    bluez
    blueman
    # Áudio (útil globalmente, mas o serviço já está em services/default.nix)
    pavucontrol
    # Utilitários do sistema
    xdg-utils
    xdg-user-dirs
    gvfs
    udisks2
    libnotify
    polkit_gnome
    gdm
    # Impressão e scanner
    cups
    simple-scan
    # Documentos e leitura
    libreoffice-fresh
    # Ferramentas CLI
    zip
    unzip
    p7zip
    unrar
    curl
    wget
    openssh
    gparted
    parted
    # Laptop utils
    brightnessctl
    # File manager
    nautilus
    # Captura e clipboard
    grim
    slurp
    swappy
    wl-clipboard
    cliphist
    # Portais e libs gráficas
    xdg-desktop-portal-hyprland
    qt5.qtwayland
    qt6.qtwayland
    gtk3
    gcc # C compiler
	ripgrep
    fd
    fzf
    python3

    # clamav
  ];
}
