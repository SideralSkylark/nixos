{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        neovim 
        git
        man-pages
        btop
        fastfetch
        nitch
        iw # Network
        bluez # Bluethoot
        blueman # Bluethooh
        pavucontrol # Audio
        xdg-utils
        xdg-user-dirs
        gvfs
        udisks2
        libnotify
        polkit_gnome
        gdm
        cups
        simple-scan
        libreoffice-fresh
        zip
        unzip
        p7zip
        unrar
        curl
        wget
        openssh
        gparted
        parted
        brightnessctl
        nautilus
        grim
        slurp
        swappy
        wl-clipboard
        cliphist
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
        usbutils
    ];
}

