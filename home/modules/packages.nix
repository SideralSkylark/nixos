{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vim #fallback
    fastfetch #info fetcher
    btop #process monitor
    git #version controll
    ripgrep #faster grep
    fd #faster find
    fzf #fuzzy find
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
