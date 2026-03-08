{ pkgs, ... }:
{
  services.dbus.enable = true;
  security.polkit.enable = true;
  services.udev.enable = true;
  services.xserver.enable = false;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
