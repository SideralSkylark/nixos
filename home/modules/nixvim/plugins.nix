{ lib, pkgs, ... }:
{
  # === AUTOCOMPLETION ===
  plugins.blink-cmp = {
    enable = true;
    settings = {
      keymap = {
        preset = "super-tab";
      };
      completion = {
        list.selection = {
          preselect = true;
          auto_insert = false;
        };

        documentation = {
          auto_show = true;
          auto_show_delay_ms = 200;
        };
      };
      signature.enabled = true;
    };
  };

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
      transparent_background = 1;
    };
  };

  # === Treesitter ===
  plugins.treesitter = {
    enable = true;
    nixGrammars = true;
    nixvimInjections = true;
    highlight.enable = true;
    indent.enable = true;
  };

  # === Formatting ===
  plugins.conform-nvim = {
    enable = true;
    settings = {
      default_format_opts = {
        lsp_format = "fallback";
      };
      format_on_save = lib.nixvim.mkRaw ''
        function(bufnr)
          if vim.g.autosaving then return end
          -- jdtls (Eclipse) formatting can create noisy diffs: format Java manually
          if vim.bo[bufnr].filetype == "java" then return end
          return { timeout_ms = 2000 }
        end
      '';
      formatters_by_ft = {
        typescript = [ "prettier" ];
        typescriptreact = [ "prettier" ];
        javascript = [ "prettier" ];
        javascriptreact = [ "prettier" ];
        vue = [ "prettier" ];
        json = [ "prettier" ];
        css = [ "prettier" ];
        html = [ "prettier" ];
        yaml = [ "prettier" ];
        rust = [ "rustfmt" ];
        nix = [ "nixfmt" ];
      };
    };
  };

  extraPackages = with pkgs; [
    prettier
    rustfmt
    nixfmt
  ];

  # === Icons / Git signs ===
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
        permanent_delete = false;
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

  # === Editing ===
  plugins.mini-pairs.enable = true;

  # === Key hints ===
  plugins.mini-clue = {
    enable = true;
    settings = {
      window = {
        # Popup only appears if you pause; quick key sequences never show it
        delay = 200;
      };
      triggers = [
        # Leader
        {
          mode = "n";
          keys = "<Leader>";
        }
        {
          mode = "x";
          keys = "<Leader>";
        }
        # [ and ] motions
        {
          mode = "n";
          keys = "[";
        }
        {
          mode = "n";
          keys = "]";
        }
        # g and z
        {
          mode = "n";
          keys = "g";
        }
        {
          mode = "x";
          keys = "g";
        }
        {
          mode = "n";
          keys = "z";
        }
        {
          mode = "x";
          keys = "z";
        }
        # Windows
        {
          mode = "n";
          keys = "<C-w>";
        }
        # Marks
        {
          mode = "n";
          keys = "'";
        }
        {
          mode = "n";
          keys = "`";
        }
        {
          mode = "x";
          keys = "'";
        }
        {
          mode = "x";
          keys = "`";
        }
        # Registers
        {
          mode = "n";
          keys = "\"";
        }
        {
          mode = "x";
          keys = "\"";
        }
        {
          mode = "i";
          keys = "<C-r>";
        }
        {
          mode = "c";
          keys = "<C-r>";
        }
      ];
      clues = [
        # Group names for your <leader> prefixes
        {
          mode = "n";
          keys = "<Leader>f";
          desc = "+Find";
        }
        {
          mode = "n";
          keys = "<Leader>x";
          desc = "+Diagnostics/Quickfix";
        }
        {
          mode = "n";
          keys = "<Leader>c";
          desc = "+Code";
        }
        # Built-in descriptions for g, z, windows, marks, registers
        (lib.nixvim.mkRaw "require('mini.clue').gen_clues.builtin_completion()")
        (lib.nixvim.mkRaw "require('mini.clue').gen_clues.g()")
        (lib.nixvim.mkRaw "require('mini.clue').gen_clues.marks()")
        (lib.nixvim.mkRaw "require('mini.clue').gen_clues.registers()")
        (lib.nixvim.mkRaw "require('mini.clue').gen_clues.windows()")
        (lib.nixvim.mkRaw "require('mini.clue').gen_clues.z()")
      ];
    };
  };

  # === Fuzzy finder ===
  plugins.fzf-lua = {
    enable = true;

    settings = {
      winopts.fullscreen = true;
      previewers.builtin.extensions = {
        png = [
          "chafa"
          "--format=symbols"
          "{file}"
        ];
        jpg = [
          "chafa"
          "--format=symbols"
          "{file}"
        ];
        jpeg = [
          "chafa"
          "--format=symbols"
          "{file}"
        ];
        webp = [
          "chafa"
          "--format=symbols"
          "{file}"
        ];
        gif = [
          "chafa"
          "--format=symbols"
          "{file}"
        ];
      };
    };
  };
}
