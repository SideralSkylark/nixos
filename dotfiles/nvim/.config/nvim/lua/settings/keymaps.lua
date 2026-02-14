-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
local x = 'x'
-- Motions
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = "Move left" })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = "Move down" })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = "Move up" })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = "Move right" })

-- keep cursor centered on Ctrl-d / Ctrl-u
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down and center' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and center' })

-- save all files 
vim.keymap.set('n', '<leader>w', ':wa<CR>', { desc = 'Save all files' })

-- lsp actions
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local opts = { buffer = bufnr, noremap = true, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  end,
})
print(x)
