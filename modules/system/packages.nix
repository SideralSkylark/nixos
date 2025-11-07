{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim 
    git
    man-pages
    docker
    docker-compose
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
    jdk21_headless
    nodejs_22
    gcc # C compiler
	ripgrep
    fd
    fzf
    python3
    jdt-language-server
    lua-language-server

    (pkgs.writeShellScriptBin "java-stable" ''
      export JAVA_HOME=${pkgs.jdk21_headless}
      exec ${pkgs.jdk21_headless}/bin/java "$@"
    '')

    # clamav
  ];
}
