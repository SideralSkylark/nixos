{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
        # Render immediately — no waiting for resources
        immediate_render = true;
      };

      auth = {
        # Standard PAM authentication
        "pam:enabled" = true;
        "pam:module" = "hyprlock";
        # Fingerprint disabled — not wanted
        "fingerprint:enabled" = false;
      };

      animations = {
        # Disable all animations — instant transitions
        enabled = false;
      };

      background = [
        {
          monitor = "";
          # Solid Kanagawa sumiInk0 — no image, no blur
          color = "rgba(16161Dff)";
          blur_passes = 0;
        }
      ];

      label = [
        {
          # Clock — dominant element, warm fujiWhite
          monitor = "";
          # $TIME built-in — more efficient than shell command
          text = "$TIME";
          color = "rgba(C8C093ff)";
          font_size = 120;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 160";
          halign = "center";
          valign = "center";
        }
        {
          # Date — muted fujiGray, secondary hierarchy
          monitor = "";
          # Update every minute — no need for per-second refresh
          text = ''cmd[update:60000] echo "$(date +"%A, %d %B %Y")"'';
          color = "rgba(727169ff)";
          font_size = 13;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 60";
          halign = "center";
          valign = "center";
        }
        {
          # Retro prompt — sumiInk4, intentionally barely visible
          monitor = "";
          text = "ENTER PASSWORD";
          color = "rgba(54546Dff)";
          font_size = 9;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, -100";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "280, 36";
          # Sharp corners — terminal aesthetic, no rounding
          rounding = 0;
          outline_thickness = 1;
          inner_color = "rgba(1F1F2800)";
          outer_color = "rgba(54546Dff)";  # sumiInk4 — idle border
          check_color = "rgba(7E9CD8ff)";  # crystalBlue — verifying
          fail_color = "rgba(C4746Eff)";   # autumnRed — wrong password
          font_color = "rgba(C8C093ff)";   # fujiWhite — typed text
          font_family = "JetBrainsMono Nerd Font";
          # Dashes instead of dots — retro terminal feel
          dots_text_format = "-";
          dots_size = 0.3;
          dots_spacing = 0.2;
          fade_on_empty = false;
          placeholder_text = "";
          fail_text = "[ $ATTEMPTS failed attempts ]";
          position = "0, -140";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
