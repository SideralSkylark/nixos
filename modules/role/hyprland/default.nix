{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    qt5.qtwayland # Wayland support for Qt 5
    qt6.qtwayland # Wayland support for Qt 6
    gtk3 # GTK 3 toolkit
    engrampa # Archive manager (GUI)
  ];

  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-volman # auto-mount drives
      thunar-archive-plugin # context menu for zip/tar/etc
    ];
  };

  services.tumbler.enable = true; # D-Bus thumbnailing service

  services.dbus.enable = true;
  security.polkit.enable = true;
  services.udev.enable = true;
  services.xserver.enable = false;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-user-session --cmd 'uwsm start hyprland-uwsm.desktop'";
      };
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
