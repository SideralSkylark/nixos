{ pkgs, ... }:

{
systemd.user.services.polkit-gnome-authentication-agent-1 = {
  Unit = {
    Description = "Polkit authentication agent for Hyprland";
    After = [ "graphical-session.target" ];
    PartOf = [ "graphical-session.target" ];
  };

  Service = {
    Type = "simple";
    ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    Restart = "on-failure";
  };

  Install = {
    WantedBy = [ "graphical-session.target" ];
  };
};


}
