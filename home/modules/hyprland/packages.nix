{ pkgs, ... }:
{
  imports = [
    ./hyprland-base.nix
  ];

  home.packages = with pkgs; [
    hypridle
    hyprsunset
    xdg-desktop-portal-hyprland # Hyprland-specific XDG portal
    firefox # Web browser
    librewolf # Privacy-focused web browser
    obsidian # Markdown-based knowledge base
    anki # Flashcard application
    libreoffice-fresh # Productivity suite (fresh version)
  ];
}
