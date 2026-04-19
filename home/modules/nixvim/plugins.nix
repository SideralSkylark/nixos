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
          lotus = {
            ui = {
              bg = "#f0ede4";
              bg_dim = "#e8e4da";
              bg_p1 = "#dedad0";
              bg_p2 = "#d4cfc4";
            };
            syn = {
              comment = "#7a7870";
            };
          };
        };
      };
    };
  };

  extraConfigLua = ''
        vim.api.nvim_create_autocmd("ColorScheme", {
          pattern = "kanagawa",
          callback = function()
            if vim.o.background == "light" then
              local o = vim.api.nvim_set_hl
              -- Normal text: near-black on warm white — max contrast, no eye strain
              o(0, "Normal",       { fg = "#1a1a16", bg = "#f0ede4" })
              o(0, "NormalNC",     { fg = "#1a1a16", bg = "#e8e4da" })
              -- Keywords: deep indigo — structure is the first thing viewers parse
              o(0, "Keyword",      { fg = "#3a4f9a", bold = true })
              o(0, "Conditional",  { fg = "#3a4f9a", bold = true })
              o(0, "Repeat",       { fg = "#3a4f9a", bold = true })
              o(0, "Statement",    { fg = "#3a4f9a", bold = true })
              -- Functions: dark teal — distinct from keywords at a distance
              o(0, "Function",     { fg = "#1a6b5a", bold = true })
              o(0, "@function",    { fg = "#1a6b5a", bold = true })
              o(0, "@method",      { fg = "#1a6b5a", bold = true })
              -- Types: warm sienna — clearly different from functions and keywords
              o(0, "Type",         { fg = "#7a4020" })
              o(0, "@type",        { fg = "#7a4020" })
              -- Strings: deep olive — readable, not competing with logic
              o(0, "String",       { fg = "#4e6320" })
              o(0, "@string",      { fg = "#4e6320" })
              -- Numbers and constants: deep rust
              o(0, "Number",       { fg = "#8c3320" })
              o(0, "Float",        { fg = "#8c3320" })
              o(0, "Constant",     { fg = "#8c3320" })
              -- Comments: warm gray, clearly tertiary
              o(0, "Comment",      { fg = "#7a7870", italic = true })
              -- Operators and punctuation: dark enough to not disappear
              o(0, "Operator",     { fg = "#3a3830" })
              o(0, "Delimiter",    { fg = "#3a3830" })
              -- Identifiers: near-black, inherit normal
              o(0, "Identifier",   { fg = "#1a1a16" })
              -- Diagnostics: keep visible on warm bg
              o(0, "DiagnosticError",   { fg = "#8c1a1a" })
              o(0, "DiagnosticWarn",    { fg = "#7a5500" })
              o(0, "DiagnosticInfo",    { fg = "#1a5a7a" })
              o(0, "DiagnosticHint",    { fg = "#1a6b5a" })
              -- mini-files integration
              o(0, "MiniFilesNormal",      { fg = "#1a1a16", bg = "#f0ede4" })
              o(0, "MiniFilesBorder",      { fg = "#d4cfc4", bg = "#f0ede4" })
              o(0, "MiniFilesTitle",       { fg = "#3a4f9a", bg = "#f0ede4" })
              o(0, "MiniFilesTitleFocused",{ fg = "#3a4f9a", bg = "#dedad0", bold = true })
              o(0, "MiniFilesDirectory",   { fg = "#1a6b5a", bold = true })
            end
          end,
        })
  '';

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
