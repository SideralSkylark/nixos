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
  colorschemes.kanagawa = {
    enable = true;
    settings = {
      theme = "wave";
      background = {
        dark = "wave";
        light = "lotus";
      };
      compile = false;
      transparent = false;
      dimInactive = false;
      commentStyle.italic = true;
      keywordStyle.italic = false;
      statementStyle.bold = false;
      functionStyle.bold = false;
      typeStyle.bold = false;
      undercurl = true;
      terminalColors = true;
      colors = {
        theme = {
          all.ui.bg_gutter = "none";
>>>>>>> 6310fc4 (fix: light theme)
        };
      };
    };
  };

  # === Statusline ===
  plugins.lualine = {
    enable = true;
    settings = {
      options = {
        section_separators = "";
        component_separators = "";
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
