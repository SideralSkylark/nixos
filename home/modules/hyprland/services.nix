{ pkgs, ... }:
{
  services.hyprsunset = {
    enable = true;
    settings = {
      max-gamma = 150;
      profile = [
        {
          # Daytime — neutral color temperature
          time = "07:30";
          temperature = 6500;
          gamma = 1.0;
        }
        {
          # Night — warm temperature to reduce eye strain
          time = "21:00";
          temperature = 4000;
          gamma = 0.9;
        }
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        # Use loginctl to trigger lock_cmd reliably before sleep
        before_sleep_cmd = "loginctl lock-session";
        # Turn display back on after resume
        after_sleep_cmd = "hyprctl dispatch dpms on";
        # Prevent duplicate hyprlock instances via pidof check
        lock_cmd = "pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
      };
      listener = [
        {
          # Lock session after 5 minutes — fires lock_cmd above
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          # Turn displays off 30s after locking — gives hyprlock
          # time to fully initialize before blanking the screen
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          # Suspend after 30 minutes of total inactivity
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

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
