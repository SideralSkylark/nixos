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
      DIR="$HOME/knowledge"
      [ -d "$DIR" ] || { echo "Directory $DIR not found"; exit 1; }
      CLIP=${pkgs.wl-clipboard}/bin/wl-copy
      fzf \
        --ansi \
        --delimiter : \
        --layout reverse \
        --preview 'LINE={2}; START=$(( LINE > 10 ? LINE - 10 : 1 )); bat --style=numbers --color=always --paging=never --highlight-line $LINE --line-range $START: {1}' \
        --preview-window 'right:60%:wrap' \
        --bind "start:reload:rg --line-number --smart-case --no-heading --color=always {q} $DIR 2>/dev/null || true" \
        --bind "change:reload:rg --line-number --smart-case --no-heading --color=always {q} $DIR 2>/dev/null || true" \
        --bind "ctrl-y:execute-silent(echo {3..} | $CLIP)" \
        --bind "ctrl-f:change-preview(bat --style=plain --color=always --paging=never {1})" \
        --bind "ctrl-r:change-preview(LINE={2}; START=$(( LINE > 10 ? LINE - 10 : 1 )); bat --style=numbers --color=always --paging=never --highlight-line $LINE --line-range $START: {1})" \
        --bind "ctrl-p:toggle-preview" \
        --header 'C-y:copy  C-f:file  C-r:reset  C-p:preview' \
        --query "$*"
    '')
    fzf
    python3
  ];
}
