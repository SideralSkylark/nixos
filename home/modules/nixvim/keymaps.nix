{
  keymaps = [
    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>lua MiniFiles.open()<CR>";
      options = {
        desc = "Open file explorer";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w>h";
      options = {
        desc = "Window left";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-w>j";
      options = {
        desc = "Window down";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<C-w>k";
      options = {
        desc = "Window up";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w>l";
      options = {
        desc = "Window right";
        silent = true;
      };
    }
    # Scroll centering
    {
      mode = "n";
      key = "<C-d>";
      action = "<C-d>zz";
      options = {
        desc = "Scroll half page down and center";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<C-u>";
      action = "<C-u>zz";
      options = {
        desc = "Scroll half page up and center";
        silent = true;
      };
    }
    # Diagnostics
    {
      mode = "n";
      key = "<leader>xx";
      action = "<CMD>Telescope diagnostics<CR>";
      options = {
        desc = "Show all diagnostics";
        silent = true;
      };
    }
    # Quickfixes
    {
      mode = "n";
      key = "]q";
      action = "<cmd>cnext<cr>";
      options.desc = "Next quickfix";
    }
    {
      mode = "n";
      key = "[q";
      action = "<cmd>cprev<cr>";
      options.desc = "Prev quickfix";
    }
    {
      mode = "n";
      key = "<leader>xq";
      action = "<cmd>copen<cr>";
      options.desc = "Open quickfix list";
    }
    # signature_help
    {
      mode = "i";
      key = "<C-k>";
      action = "<cmd>lua vim.lsp.buf.signature_help()<cr>";
      options = {
        desc = "Signature help";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>ff";
      action = "<cmd>Telescope find_files<cr>";
      options.desc = "Find files";
    }
    {
      mode = "n";
      key = "<leader>fg";
      action = "<cmd>Telescope live_grep<cr>";
      options.desc = "Live grep";
    }
    {
      mode = "n";
      key = "<leader>q";
      action = "<cmd>bd<cr>";
      options.desc = "Close buffer";
    }
    {
      mode = [
        "n"
        "i"
      ];
      key = "<C-s>";
      action = "<cmd>w<cr>";
      options = {
        desc = "Save file";
        silent = true;
      };
    }
  ];

  extraConfigLua = ''
    vim.api.nvim_create_autocmd({"InsertLeave", "FocusLost"}, {
      callback = function()
        if
          vim.bo.modified
          and not vim.bo.readonly
          and vim.bo.buftype == ""
          and vim.bo.filetype ~= ""
          and vim.fn.expand("%") ~= ""
        then
          vim.cmd("silent! write")
        end
      end,
    })
                	
    -- Highlight on yank
    vim.api.nvim_create_autocmd('TextYankPost', {
      desc = 'Highlight when yanking text',
      group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
      callback = function() vim.hl.on_yank() end,
    })
  '';
}
