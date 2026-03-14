{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fastfetch
    nitch

    btop

    git
    ripgrep
    fd
    fzf

    curl
    wget

    zip
    unzip
    p7zip
    unrar

    openssh
    man-pages
  ];
}
