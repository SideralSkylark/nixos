return {
    -- Formatting
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        config = function()
            require("conform").setup({
                format_on_save   = { timeout_ms = 500, lsp_fallback = true },
                formatters_by_ft = {
                    typescript      = { "prettier" },
                    typescriptreact = { "prettier" },
                    javascript      = { "prettier" },
                    javascriptreact = { "prettier" },
                    vue             = { "prettier" },
                    rust            = { "rustfmt" },
                    nix             = { "nixfmt" },
                },
            })
        end,
    },

    -- FzfLua
    {
        "ibhagwan/fzf-lua",
        cmd = "FzfLua",
        keys = {
            { "<leader>ff", "<cmd>FzfLua files<cr>",                 desc = "Find files" },
            { "<leader>fg", "<cmd>FzfLua live_grep<cr>",             desc = "Live grep" },
            { "<leader>xx", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace diagnostics" },
        },
        config = function()
            require("fzf-lua").setup({
                winopts = { fullscreen = true },
                grep    = { rg_opts = "--column --line-number --no-heading --color=always --smart-case" },
            })
        end,
    },
}
