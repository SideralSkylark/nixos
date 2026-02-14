return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",  
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,      
        popup_border_style = "rounded",   
        enable_git_status = true,         
        enable_diagnostics = true,        
        sort_case_insensitive = true,     
        default_component_configs = {
          icon = { 
						folder_closed = "", 
						folder_open = "", 
						folder_empty = "ﰊ" 
					},
          git_status = 
						{ symbols = { 
							added = "+", 
							modified = "~", 
							deleted = "x" 
						  } 
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

      vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle Neo-tree" })
    end,
  },
}

