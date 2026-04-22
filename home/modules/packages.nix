{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vim # Text editor (fallback)
    fastfetch # System information fetcher
    btop # Resource monitor
    ripgrep # High-performance search tool
    fd # Simple and fast alternative to 'find'
    fzf # Command-line fuzzy finder
    curl # Transfer data with URLs
    wget # Retrieve files from the web
    zip # Archive utility
    unzip # Unzip utility
    p7zip # 7z compression utility
    unrar # RAR archive extractor
    man-pages # Linux manual pages
  ];
}
