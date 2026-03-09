{ pkgs, ... }:

{
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    Unit = {
      Description = "Polkit authentication agent for Hyprland";
      After = [ "hyprland-session.target" ]; # ← muda aqui
      PartOf = [ "hyprland-session.target" ]; # ← e aqui
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 3;
    };
    Install = {
      WantedBy = [ "hyprland-session.target" ]; # ← e aqui
    };
  };
}
