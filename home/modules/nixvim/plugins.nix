{
  # === AUTOCOMPLETION ===
  plugins.cmp = {
    enable = true;
    settings = {
      mapping = {
        "<C-n>" = "cmp.mapping.select_next_item()";
        "<C-p>" = "cmp.mapping.select_prev_item()";
        "<C-Space>" = "cmp.mapping.complete()";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
      };
      sources = [
        { name = "nvim_lsp"; }
        { name = "path"; }
        { name = "buffer"; }
      ];
    };
  };
  plugins.cmp-nvim-lsp.enable = true;
  plugins.cmp-buffer.enable = true;
  plugins.cmp-path.enable = true;
  plugins.web-devicons.enable = true;

  # === Colorscheme ===
  colorschemes.everforest = {
    enable = true;
    settings = {
      background = "hard";
      enable_italic = 1;
      disable_italic_comment = 0;
      sign_column_background = "none";
      diagnostic_text_highlight = 0;
      inlay_hints_background = "none";
      float_style = "bright";
      ui_contrast = "high";
      dim_inactive_windows = 0;
      show_eob = 1;
      spell_foreground = "none";
      transparent_background = 0;
    };
  };

  # === Statusline ===
  plugins.lualine = {
    enable = true;
    settings = {
      options = {
        section_separators = {
          left = "";
          right = "";
        };
        component_separators = {
          left = "|";
          right = "|";
        };
        theme = "everforest";
        globalstatus = true;
        disabled_filetypes = [ "minifiles" ];
        icons_enabled = true;
      };
      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [ "branch" ];
        lualine_c = [
          "filename"
          "diff"
        ];
        lualine_x = [
          "diagnostics"
          "filetype"
        ];
        lualine_y = [ ];
        lualine_z = [ "location" ];
      };
    };
  };

  # === Treesitter ===
  plugins.treesitter = {
    enable = true;
    nixGrammars = true;
    nixvimInjections = true;
    settings = {
      ensure_installed = [
        "typescript"
        "java"
        "nix"
        "c"
        "rust"
      ];
      highlight.enable = true;
      indent.enable = true;
    };
  };

  # === File Explorer ===
  plugins.mini-files = {
    enable = true;
    settings = {
      options = {
        use_as_default_explorer = true;
        permanent_delete = true;
      };
      windows = {
        preview = false;
        width_focus = 40;
        width_nofocus = 20;
      };
      mappings = {
        close = "q";
        go_in = "l";
        go_out = "h";
        reset = "<BS>";
        show_help = "g?";
      };
    };
  };
  plugins.mini-pairs.enable = true;

  # === Fuzzy Finder ===
  plugins.telescope = {
    enable = true;
    settings = {
      defaults = {
        sorting_strategy = "ascending";
        layout_strategy = "flex";
      };
    };
  };
}
