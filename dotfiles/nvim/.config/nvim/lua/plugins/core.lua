return {
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  -- Telescope
  { 
    "nvim-telescope/telescope.nvim", 
    tag = "0.1.5", 
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
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
      -- Buscar arquivos na máquina inteira
      vim.keymap.set('n', '<leader>fF', function()
        builtin.find_files({ cwd = "/" })
      end, { desc = "Find files anywhere" })
      -- Buscar palavras dentro de arquivos
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
      -- Buffers abertos
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Buffers" })
      -- Help tags
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help tags" })

    end
  },
  { 
		"nvim-treesitter/nvim-treesitter", 
		build = ":TSUpdate", 
		config = function()
    require('nvim-treesitter.configs').setup {
      -- Quais linguagens instalar automaticamente
      ensure_installed = { "lua", "java", "python", "javascript", "typescript", "html", "css", "markdown" },

      -- Habilitar highlight
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      -- Habilitar indentação automática
      indent = {
        enable = true,
      },

      -- Seleção incremental (como visual select inteligente)
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",  -- iniciar seleção
          node_incremental = "grn", -- aumentar seleção
          scope_incremental = "grc", -- aumentar escopo
          node_decremental = "grm", -- diminuir seleção
        },
      },

      -- Playground (útil para debugar queries e ver a árvore)
      playground = {
        enable = true,
        disable = {},
        updatetime = 25,
        persist_queries = false,
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      },
    }
  end
	},
}
