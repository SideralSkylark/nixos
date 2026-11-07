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

  # colorschemes.everforest = {
  #   enable = true;
  #   settings = {
  #     background = "hard";
  #     transparent_background = 0;
  #     ui_contrast = "low";
  #   };
  # };

  colorschemes.gruvbox-material = {
    enable = true;
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
