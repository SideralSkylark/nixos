{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kitty # Terminal emulator
    pamixer # PulseAudio mixer for CLI
    playerctl # Controller for media players
    brightnessctl # Tool to read and control device brightness
    grim # Wayland screenshot tool
    slurp # Select a region in a Wayland compositor
    swappy # Wayland native snapshot editing tool
    imv # Image viewer for Wayland
    wl-clipboard # Command-line copy/paste utilities for Wayland
    cliphist # Wayland clipboard manager
    waybar # Highly customizable Wayland bar
    fuzzel # Wayland-native application launcher
    impala # TUI for managing wifi on Linux
    yazi # Terminal file manager
  ];
}
