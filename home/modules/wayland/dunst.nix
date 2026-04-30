{ pkgs, ... }:
{
  services.dunst = {
    enable = true;
    iconTheme = {
      name    = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
      size    = "32x32";
    };
    settings = {
      global = {
        monitor = 0;
        follow  = "none";
        # ── Geometry ──────────────────────────────
        width    = "(260, 400)";
        height   = 150;
        origin   = "top-right";
        offset   = "8x8";
        scale    = 0;
        gap_size = 8;
        # ── Layout ────────────────────────────────
        padding            = 10;
        horizontal_padding = 14;
        text_icon_padding  = 12;
        icon_position      = "left";
        min_icon_size      = 24;
        max_icon_size      = 32;
        icon_corner_radius = 2;
        enable_recursive_icon_lookup = true;
        # ── Border ────────────────────────────────
        corner_radius    = 0;
        frame_width      = 2;
        frame_color      = "#374145";
        separator_height = 1;
        separator_color  = "frame";
        # ── Typography ────────────────────────────
        font               = "JetBrainsMono Nerd Font 11";
        markup             = "full";
        format             = "<b>%s</b>\n<span foreground='#7A8478' size='small'>%a</span>\n<span foreground='#D3C6AA'>%b</span>";
        alignment          = "left";
        vertical_alignment = "center";
        line_height        = 2;
        word_wrap          = true;
        ellipsize          = "end";
        show_age_threshold = 60;
        # ── Colors ────────────────────────────────
        background = "#272E33";
        foreground = "#D3C6AA";
        highlight  = "#7FBBB3";
        # ── Progress bar ──────────────────────────
        progress_bar               = true;
        progress_bar_height        = 3;
        progress_bar_frame_width   = 0;
        progress_bar_min_width     = 150;
        progress_bar_max_width     = 300;
        progress_bar_corner_radius = 2;
        # ── Behaviour ─────────────────────────────
        stack_duplicates     = true;
        hide_duplicate_count = false;
        show_indicators      = true;
        history_length       = 20;
        sticky_history       = true;
        always_run_script    = true;
        # ── Mouse ─────────────────────────────────
        mouse_left_click   = "do_action, close_current";
        mouse_middle_click = "close_all";
        mouse_right_click  = "close_current";
      };
      urgency_low = {
        background  = "#272E33";
        foreground  = "#D3C6AA";
        frame_color = "#374145";
        highlight   = "#83C092";
        timeout     = 4;
      };
      urgency_normal = {
        background  = "#272E33";
        foreground  = "#D3C6AA";
        frame_color = "#7FBBB3";
        highlight   = "#7FBBB3";
        timeout     = 6;
      };
      urgency_critical = {
        background  = "#272E33";
        foreground  = "#E67E80";
        frame_color = "#E67E80";
        highlight   = "#E67E80";
        timeout     = 0;
      };
    };
  };
}
