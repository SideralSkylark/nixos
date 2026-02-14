-- status line
return {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = { 
					theme = "kanagawa", 
					section_separators = "", 
					component_separators = "",
					disabled_filetypes = { "neo-tree", "neo-tree-popup", "notify" }
				},
				sections = {
					lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "filetype" },
          lualine_y = {},
          lualine_z = {}
				}
      })
    end,
  }
}

