local opt          = vim.opt
local g            = vim.g

g.mapleader        = " "
g.maplocalleader   = "\\"

opt.scrolloff      = 8
opt.sidescrolloff  = 8
opt.clipboard      = "unnamedplus"
opt.laststatus     = 3
opt.ignorecase     = true
opt.smartcase      = true
opt.number         = true
opt.relativenumber = true
opt.signcolumn     = "yes"
opt.tabstop        = 4
opt.softtabstop    = 4
opt.shiftwidth     = 4
opt.expandtab      = true
opt.updatetime     = 300
opt.termguicolors  = true
opt.wrap           = false
opt.undofile       = true
opt.swapfile       = false
opt.backup         = false
opt.writebackup    = false
opt.splitright     = true
opt.splitbelow     = true

vim.treesitter.language.add("typescript")
vim.treesitter.language.add("java")
vim.treesitter.language.add("nix")
vim.treesitter.language.add("c")
vim.treesitter.language.add("rust")
vim.treesitter.language.add("lua")
