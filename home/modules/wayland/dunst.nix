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
        width = "(260, 400)";   
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
        icon_corner_radius = 4;  
        enable_recursive_icon_lookup = true;
        # ── Border ────────────────────────────────
        corner_radius = 0;      
        frame_width = 1;
        frame_color = "#2A2A37";
        separator_height = 1;
        separator_color = "frame"; 
        # ── Typography ────────────────────────────
        font = "JetBrainsMono Nerd Font 11"; 
        markup = "full";
        # cleaner hierarchy: bold summary, dimmed app name, normal body
        format = "<b>%s</b>\n<span foreground='#3D3D52' size='small'>%a</span>\n<span foreground='#9E9B8E'>%b</span>";
        alignment = "left";
        vertical_alignment = "center";
        line_height = 1;         
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
        foreground = "#C8C093";  
        frame_color = "#2A2A37"; 
        highlight = "#7AA89F";   
        timeout = 4;            
      };

      # crystalBlue — present, readable
      urgency_normal = {
        background = "#1F1F28";
        foreground = "#DCD7BA";  
        frame_color = "#7E9CD8"; 
        highlight = "#7E9CD8";
        timeout = 6;            
      };

      # peachRed — urgent, eyes drawn immediately
      urgency_critical = {
        background = "#1F1F28";  
        foreground = "#E46876"; 
        frame_color = "#E46876";
        highlight = "#FF5D62";  
        timeout = 0;
      };
    };
  };
}
