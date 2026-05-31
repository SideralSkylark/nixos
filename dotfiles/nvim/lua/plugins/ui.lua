return {
    -- Colorscheme
    {
        "neanias/everforest-nvim",
        priority = 1000,
        lazy = false,
        config = function()
            require("everforest").setup({
                background             = "hard",
                enable_italic          = true,
                disable_italic_comment = false,
                sign_column_background = "none",
                float_style            = "dim",
                ui_contrast            = "low",
                dim_inactive_windows   = false,
                show_eob               = false,
                transparent_background = 0,
            })
            vim.cmd("colorscheme everforest")
        end,
    },

    -- Mini
    {
        "echasnovski/mini.nvim",
        event = "VimEnter",
        config = function()
            require("mini.icons").setup({ mock_dev_icons = true })
            require("mini.diff").setup()
            require("mini.files").setup({
                options  = { use_as_default_explorer = true, permanent_delete = true },
                windows  = { preview = false, width_focus = 40, width_nofocus = 20 },
                mappings = { close = "q", go_in = "l", go_out = "h", reset = "<BS>", show_help = "g?" },
            })
            require("mini.pairs").setup()
        end,
    },
}
