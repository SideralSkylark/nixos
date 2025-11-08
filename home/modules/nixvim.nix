{ config, pkgs, nixvim, ... }:

{
  programs.nixvim = {
    enable = true;

    plugins = {
      lsp.enable = true;
      lsp.servers = {
        lua_ls.enable = true;
        ts_ls.enable = true;
        volar.enable = true;
        jdtls.enable = true;
      };

      treesitter.enable = true;

      telescope.enable = true;

      cmp.enable = true;

      which-key.enable = true;
    };

    options = {
      number = true;
      relativenumber = true;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      termguicolors = true;
      completeopt = "menu,menuone,noselect";
      mouse = "a";
    };

    extraLuaConfig = ''
      local border = "rounded"
      vim.diagnostic.config({
        float = { border = border, source = "always" },
      })
      vim.opt.updatetime = 300
      vim.opt.timeoutlen = 500
      vim.cmd("set signcolumn=yes")
      vim.cmd("set completeopt=menu,menuone,noselect")
    '';
  };
}

