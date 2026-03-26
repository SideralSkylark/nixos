{ pkgs, ... }:
{
  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
      size = "32x32";
    };
    settings = {
      global = {
        monitor = 0;
        follow = "none";
        # ── Geometry ──────────────────────────────
        width = "(260, 400)";       # bumped min slightly — 240 clips longer summaries
        height = 150;
        origin = "top-right";
        offset = "14x14";
        scale = 0;
        gap_size = 6;
        # ── Layout ────────────────────────────────
        padding = 10;
        horizontal_padding = 14;
        text_icon_padding = 12;
        icon_position = "left";
        min_icon_size = 24;
        max_icon_size = 32;
        icon_corner_radius = 4;    # softened slightly — retro but not fully harsh
        enable_recursive_icon_lookup = true;
        # ── Border ────────────────────────────────
        corner_radius = 0;         # sharp = retro terminal feel, keep this
        frame_width = 1;
        frame_color = "#2A2A37";
        separator_height = 1;
        separator_color = "frame"; # inherits per-urgency frame_color — more cohesive
        # ── Typography ────────────────────────────
        font = "JetBrainsMono Nerd Font 11"; # 12 runs wide in the min-width range; 11 breathes better
        markup = "full";
        # cleaner hierarchy: bold summary, dimmed app name, normal body
        format = "<b>%s</b>\n<span foreground='#3D3D52' size='small'>%a</span>\n<span foreground='#9E9B8E'>%b</span>";
        alignment = "left";
        vertical_alignment = "center";
        line_height = 1;           # 2 adds too much gap between app name and body; 1 tightens it
        word_wrap = true;
        ellipsize = "end";
        show_age_threshold = 60;
        # ── Colors (Kanagawa — sumiInk base) ──────
        background = "#1F1F28";
        foreground = "#DCD7BA";
        highlight = "#7E9CD8";
        # ── Progress bar ──────────────────────────
        progress_bar = true;
        progress_bar_height = 3;
        progress_bar_frame_width = 0;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        progress_bar_corner_radius = 0;
        # ── Behaviour ─────────────────────────────
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = true;
        history_length = 20;
        sticky_history = true;
        always_run_script = true;
        # ── Mouse ─────────────────────────────────
        mouse_left_click = "do_action, close_current";
        mouse_middle_click = "close_all";
        mouse_right_click = "close_current";
      };

      # waveAqua2 — barely-there, quiet
      urgency_low = {
        background = "#1F1F28";
        foreground = "#C8C093";    # fujiWhite dimmed
        frame_color = "#2A2A37";   # invisible border — blends in
        highlight = "#7AA89F";     # waveAqua2
        timeout = 4;               # 3 is too quick for slow glancers
      };

      # crystalBlue — present, readable
      urgency_normal = {
        background = "#1F1F28";
        foreground = "#DCD7BA";    # fujiWhite
        frame_color = "#7E9CD8";   # crystalBlue border accent
        highlight = "#7E9CD8";
        timeout = 6;               # bumped from 5 — typical read time
      };

      # peachRed — urgent, eyes drawn immediately
      urgency_critical = {
        background = "#1F1F28";    # keep bg consistent — the border does the work
        foreground = "#E46876";    # peachRed
        frame_color = "#E46876";
        highlight = "#FF5D62";     # samuraiRed for progress bar
        timeout = 0;
      };
    };
  };
}
