return {
    {
        "saghen/blink.cmp",
        version = "*",
        opts = {
            keymap = {
                preset        = "none",
                ["<C-Space>"] = { "show", "fallback" },
                ["<C-n>"]     = { "select_next", "fallback" },
                ["<C-p>"]     = { "select_prev", "fallback" },
                ["<CR>"]      = { "accept", "fallback" },
                ["<C-e>"]     = { "cancel", "fallback" },
            },
            sources = {
                default = { "lsp", "path", "buffer" },
            },
            completion = {
                documentation = { auto_show = true, auto_show_delay_ms = 200 },
            },
        },
    },
}
