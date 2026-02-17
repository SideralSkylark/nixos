{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    git
    man-pages
    zip
    unzip
    p7zip
    unrar
    curl
    wget
    openssh
    usbutils
    parted
    gparted
    cups
    simple-scan
    libreoffice-fresh
    gcc
    # C compiler
    ripgrep
    fd
    (pkgs.writeShellScriptBin "kn" ''
      rg --line-number --smart-case "$@" "$HOME/knowledge" | fzf \
        --delimiter : \
        --preview 'bat --style=numbers --color=always --paging=never {1} --highlight-line {2}' \
        --preview-window right:60%
    '')
    fzf
    python3
  ];
}
