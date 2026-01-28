{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        neovim 
        git
        man-pages
        zip unzip p7zip unrar
        curl
        wget
        openssh
        usbutils
        parted gparted
        cups
        simple-scan
        libreoffice-fresh
        gcc # C compiler
	    ripgrep
        fd
        fzf
        python3
    ];
}

