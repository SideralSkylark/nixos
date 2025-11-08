{ pkgs, lib, ... }:
{
  config = {
    plugins.lsp.enable = true;
    extraPlugins = with pkgs.vimPlugins; [
      kanagawa-nvim
      neo-tree-nvim
      nvim-web-devicons
      lualine-nvim
      nvim-autopairs
      telescope-nvim
      nvim-treesitter
      plenary-nvim
      nui-nvim
    ];
    # === Kanagawa Colorscheme ===
    colorschemes.kanagawa.enable = true;
    colorschemes.kanagawa.autoLoad = true;
    colorschemes.kanagawa.settings = {
      theme = "wave";                                
      background = { dark = "wave"; light = "lotus"; };
      transparent = false;                          
      #colors = { theme = { all = { ui = {  }; }; }; };
      commentStyle = { italic = true; };
      keywordStyle = { italic = true; };
      statementStyle = { bold = true; };
      undercurl = true;
      terminalColors = true;
    };

	globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };

	keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree toggle<cr>";
        options = { desc = "Toggle Neo-tree"; silent = true; };
      }
	  { mode = "n"; key = "<C-h>"; action = "<C-w>h"; options = { desc = "Window left"; silent = true; }; }
      { mode = "n"; key = "<C-j>"; action = "<C-w>j"; options = { desc = "Window down"; silent = true; }; }
      { mode = "n"; key = "<C-k>"; action = "<C-w>k"; options = { desc = "Window up"; silent = true; }; }
      { mode = "n"; key = "<C-l>"; action = "<C-w>l"; options = { desc = "Window right"; silent = true; }; }

      # Scroll centering
      { mode = "n"; key = "<C-d>"; action = "<C-d>zz"; options = { desc = "Scroll half page down and center"; silent = true; }; }
      { mode = "n"; key = "<C-u>"; action = "<C-u>zz"; options = { desc = "Scroll half page up and center"; silent = true; }; }

      # Save all buffers
      { mode = "n"; key = "<leader>w"; action = ":wa<CR>"; options = { desc = "Save all buffers"; silent = true; }; }
    ];

	plugins.lualine.enable = true;
    plugins.lualine.autoLoad = true;
    plugins.lualine.settings = {
      options = {
        section_separators = "";
        component_separators = "";
        globalstatus = true;
        disabled_filetypes = [ "neo-tree" "neo-tree-popup" "notify" ];
        icons_enabled = true;
      };
      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [ "branch" ];
        lualine_c = [ "filename" "diff" ];
        lualine_x = [
          "diagnostics"
          {
            __raw = ''
              function()
                local msg = ""
                local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                local clients = vim.lsp.get_active_clients()
                if next(clients) == nil then return msg end
                for _, client in ipairs(clients) do
                  local filetypes = client.config.filetypes
                  if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    return client.name
                  end
                end
                return msg
              end
            '';
            color = { fg = "#ffffff"; };
            icon = "";
          }
          "encoding"
          "fileformat"
          "filetype"
        ];
        lualine_y = [ "progress" ];
        lualine_z = [ "location" ];
      };
      inactive_sections = {
        lualine_a = [ "mode" ];
        lualine_b = [ "branch" ];
        lualine_c = [ "filename" ];
        lualine_x = [ "location" ];
        lualine_y = [];
        lualine_z = [];
      };
    };

	# === Treesitter ===
    plugins.treesitter = {
      enable = true;
      autoLoad = true;
      nixGrammars = true;
      nixvimInjections = true;
      settings = {
        auto_install = false;
        sync_install = false;
		parser_install_dir = "/home/skylark/.local/share/nvim/treesitter";
        ensure_installed = [ "lua" "python" "javascript" "typescript" "html" "css" "markdown" "java" "nix" "c" "rust" ];
        highlight = { enable = true; additional_vim_regex_highlighting = false; };
        indent = { enable = true; };
        incremental_selection = {
          enable = true;
          keymaps = {
            init_selection = "gnn";
            node_incremental = "grn";
            node_decremental = "grm";
            scope_incremental = "grc";
          };
        };
      };
    };

    extraConfigLua = ''
      -- Neo-tree setup
      require("neo-tree").setup({
        nlose_if_last_window = true,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        sort_case_insensitive = true,
        default_component_configs = {
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "ﰊ",
          },
          git_status = {
            symbols = { added = "+", modified = "~", deleted = "x" },
          },
        },
        window = {
          position = "right",
          width = 35,
          mappings = {
            ["o"] = "open",
            ["<CR>"] = "open",
            ["s"] = "split_with_window_picker",
            ["v"] = "vsplit_with_window_picker",
            ["t"] = "open_tabnew",
            ["h"] = "close_node",
            ["l"] = "open",
            ["R"] = "refresh",
            ["a"] = "add",
            ["d"] = "delete",
            ["r"] = "rename",
          },
        },
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
          },
        },
      })
      -- Highlight on yank
      vim.api.nvim_create_autocmd('TextYankPost', {
        desc = 'Highlight when yanking text',
        group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
        callback = function() vim.hl.on_yank() end,
      })
	  -- Nvim-autopairs setup
      require("nvim-autopairs").setup()
	  -- Telescope setup
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
      local actions = require("telescope.actions")
      telescope.setup{
        defaults = {
          prompt_prefix = " ",
          selection_caret = "➤ ",
          sorting_strategy = "ascending",
          layout_strategy = "flex",
          preview = true,
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
        },
      }
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files in cwd" })
      vim.keymap.set('n', '<leader>fF', function() builtin.find_files({ cwd = "/" }) end, { desc = "Find files anywhere" })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Buffers" })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help tags" })
    '';
    # === Editor options ===
    opts = {
      number = true;
      relativenumber = true;
      signcolumn = "yes";
      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      winborder = "rounded";
    };
  };
}
