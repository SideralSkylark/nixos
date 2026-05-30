{ ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor         = true;
        ignore_empty_input  = true;
        immediate_render    = true;
      };
      auth = {
        "pam:enabled"          = true;
        "pam:module"           = "hyprlock";
        "fingerprint:enabled"  = false;
      };
      animations = {
        enabled = false;
      };
      background = [
        {
          monitor     = "";
          color       = "rgba(272E33ff)";   # bg-base — hard dark
          blur_passes = 0;
        }
      ];
      label = [
        {
          # Clock — dominant element
          monitor     = "";
          text        = "$TIME";
          color       = "rgba(D3C6AAff)";   # fg-default
          font_size   = 120;
          font_family = "JetBrainsMono Nerd Font";
          position    = "0, 160";
          halign      = "center";
          valign      = "center";
        }
        {
          # Date — muted, secondary hierarchy
          monitor     = "";
          text        = ''cmd[update:60000] echo "$(date +"%A, %d %B %Y")"'';
          color       = "rgba(7A8478ff)";   # fg-muted
          font_size   = 13;
          font_family = "JetBrainsMono Nerd Font";
          position    = "0, 60";
          halign      = "center";
          valign      = "center";
        }
        {
          # Retro prompt — barely visible, intentional
          monitor     = "";
          text        = "ENTER PASSWORD";
          color       = "rgba(525C5Aff)";   # fg-subtle
          font_size   = 9;
          font_family = "JetBrainsMono Nerd Font";
          position    = "0, -100";
          halign      = "center";
          valign      = "center";
        }
      ];
      input-field = [
        {
          monitor           = "";
          size              = "280, 36";
          rounding          = 0;             # sharp — terminal aesthetic
          outline_thickness = 1;
          inner_color       = "rgba(272E3300)";  # transparent fill
          outer_color       = "rgba(525C5Aff)";  # fg-subtle — idle border
          check_color       = "rgba(7FBBB3ff)";  # accent-blue — verifying
          fail_color        = "rgba(E67E80ff)";  # accent-red — wrong password
          font_color        = "rgba(D3C6AAff)";  # fg-default — typed text
          font_family       = "JetBrainsMono Nerd Font";
          dots_text_format  = "-";               # dashes — retro terminal feel
          dots_size         = 0.3;
          dots_spacing      = 0.2;
          fade_on_empty     = false;
          placeholder_text  = "";
          fail_text         = "[ $ATTEMPTS failed attempts ]";
          position          = "0, -140";
          halign            = "center";
          valign            = "center";
        }
      ];
    };
  };
}
