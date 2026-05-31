local map = function(mode, lhs, rhs, opts)
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- Windows
map("n", "<C-h>", "<C-w>h", { desc = "Window left", silent = true })
map("n", "<C-j>", "<C-w>j", { desc = "Window down", silent = true })
map("n", "<C-k>", "<C-w>k", { desc = "Window up", silent = true })
map("n", "<C-l>", "<C-w>l", { desc = "Window right", silent = true })

-- Scroll centering
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center", silent = true })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center", silent = true })

-- File explorer
map("n", "<leader>e", function()
    require("mini.files").open()
end, { desc = "Open file explorer", silent = true })

-- Save
map({ "n", "i" }, "<C-s>", "<cmd>w<cr>", { desc = "Save file", silent = true })

-- Buffer
map("n", "<leader>q", "<cmd>bd<cr>", { desc = "Close buffer" })

-- Format
map("n", "<leader>f", function()
    require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })

-- Quickfix
map("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix" })
map("n", "[q", "<cmd>cprev<cr>", { desc = "Prev quickfix" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Open quickfix list" })

-- Diagnostics
map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Prev diagnostic" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next diagnostic" })
map("n", "gl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

-- LSP (set on attach)
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        map("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
        map("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Show references" }))
        map("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
        map("n", "gt", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Type definition" }))
        map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover docs" }))
        map("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
        map("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code actions" }))
    end,
})

-- Autocmds
vim.api.nvim_create_autocmd({ "InsertLeave", "FocusLost" }, {
    callback = function()
        if vim.bo.modified
            and not vim.bo.readonly
            and vim.bo.buftype == ""
            and vim.bo.filetype ~= ""
            and vim.fn.expand("%") ~= ""
        then
            vim.cmd("silent! write")
        end
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function() vim.hl.on_yank() end,
})

vim.diagnostic.config({
    virtual_text     = false,
    signs            = true,
    underline        = true,
    update_in_insert = false,
    severity_sort    = true,
})
