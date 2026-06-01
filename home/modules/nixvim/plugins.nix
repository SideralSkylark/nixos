{ pkgs, ... }:
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
      float_style = "dim";
      ui_contrast = "low";
      dim_inactive_windows = 0;
      show_eob = 0;
      spell_foreground = "none";
      transparent_background = 0;
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

  plugins.conform-nvim = {
    enable = true;
    settings = {
      format_on_save = {
        timeout_ms = 500;
        lsp_fallback = true;
      };
      formatters_by_ft = {
        typescript = [ "prettier" ];
        typescriptreact = [ "prettier" ];
        javascript = [ "prettier" ];
        javascriptreact = [ "prettier" ];
        vue = [ "prettier" ];
        rust = [ "rustfmt" ];
        nix = [ "nixfmt" ];
      };
    };
  };

  extraPackages = with pkgs; [
    prettier
    rustfmt
    nixfmt-rfc-style
    google-java-format
  ];

  plugins.mini-icons = {
    enable = true;
    mockDevIcons = true;
  };

  plugins.mini-diff.enable = true;

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

  plugins.fzf-lua = {
    enable = true;

    settings = {
      winopts.fullscreen = true;
      grep.rg_opts = "--column --line-number --no-heading --color=always --smart-case";
    };
  };
}
