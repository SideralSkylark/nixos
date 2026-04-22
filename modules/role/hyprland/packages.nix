{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    qt5.qtwayland # Wayland support for Qt 5
    qt6.qtwayland # Wayland support for Qt 6
    gtk3 # GTK 3 toolkit
    mate.engrampa # Archive manager (GUI)
  ];

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-volman # auto-mount drives
      thunar-archive-plugin # context menu for zip/tar/etc
    ];
  };

  services.tumbler.enable = true; # D-Bus thumbnailing service
}
