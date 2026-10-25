{ lib, ... }:
{
  keymaps = [
    # Explorer
    {
      mode = "n";
      key = "<leader>e";
      action = ''<cmd>lua local p = vim.api.nvim_buf_get_name(0); require("mini.files").open(p ~= "" and p or vim.uv.cwd(), true)<CR>'';
      options = {
        desc = "Open file explorer (buffer dir)";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>E";
      action = "<cmd>lua MiniFiles.open()<CR>";
      options = {
        desc = "Open file explorer";
        silent = true;
      };
    }

    # Windows
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
    {
      mode = "n";
      key = "n";
      action = "nzzzv";
      options = {
        desc = "Next match (centered)";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "N";
      action = "Nzzzv";
      options = {
        desc = "Previous match (centered)";
        silent = true;
      };
    }

    # Search / editing
    {
      mode = "n";
      key = "<Esc>";
      action = "<cmd>nohlsearch<CR>";
      options = {
        desc = "Clear search highlight";
        silent = true;
      };
    }

    # Buffers
    {
      mode = "n";
      key = "<leader>q";
      action = "<cmd>bd<CR>";
      options = {
        desc = "Close buffer";
        silent = true;
      };
    }

    # Find
    {
      mode = "n";
      key = "<leader>ff";
      action = "<cmd>FzfLua files<cr>";
      options.desc = "Find files";
    }
    {
      mode = "n";
      key = "<leader>fg";
      action = "<cmd>FzfLua live_grep<cr>";
      options.desc = "Live grep";
    }
    {
      mode = "n";
      key = "<leader>fs";
      action = "<cmd>FzfLua lsp_document_symbols<cr>";
      options.desc = "Symbols in file";
    }
    {
      mode = "n";
      key = "<leader>fi";
      action = lib.nixvim.mkRaw ''
        function()
          require("fzf-lua").files({
            prompt = "Images> ",
            file_icons = false,
            git_icons = false,
            cmd = "fd --type f --hidden --no-ignore --exclude .git --exclude node_modules --exclude target --exclude .direnv --extension png --extension jpg --extension jpeg --extension webp --extension gif",
          })
        end
      '';
      options.desc = "Find images (hidden + ignored dirs, opens in imv)";
    }

    # Diagnostics
    {
      mode = "n";
      key = "<leader>xx";
      action = "<cmd>FzfLua diagnostics_workspace<cr>";
      options = {
        desc = "Workspace diagnostics";
        silent = true;
      };
    }

    # Quickfix
    {
      mode = "n";
      key = "<leader>xq";
      action = "<cmd>copen<cr>";
      options.desc = "Open quickfix list";
    }

    # LSP (same keys as the 0.12 built-ins, fzf UI)
    {
      mode = "n";
      key = "grr";
      action = "<cmd>FzfLua lsp_references<cr>";
      options.desc = "References";
    }
    {
      mode = "n";
      key = "gri";
      action = "<cmd>FzfLua lsp_implementations<cr>";
      options.desc = "Implementations";
    }

    # Code
    {
      mode = "n";
      key = "<leader>cf";
      action = "<cmd>lua require('conform').format({ async = true })<cr>";
      options.desc = "Format buffer";
    }
    {
      mode = "n";
      key = "<leader>u";
      action = "<cmd>packadd nvim.undotree<cr><cmd>Undotree<cr>";
      options.desc = "Undo tree";
    }

    # Save
    {
      mode = [
        "n"
        "i"
      ];
      key = "<C-s>";
      action = "<cmd>w<cr>";
      options = {
        desc = "Save file (and format)";
        silent = true;
      };
    }
  ];

  extraConfigLua = ''
    -- Autosave on leaving insert / losing focus.
    -- The flag lets conform skip formatting for these saves (<C-s> and :w still format).
    vim.api.nvim_create_autocmd({"InsertLeave", "FocusLost"}, {
      callback = function()
        if
          vim.bo.modified
          and not vim.bo.readonly
          and vim.bo.buftype == ""
          and vim.bo.filetype ~= ""
          and vim.fn.expand("%") ~= ""
        then
          vim.g.autosaving = true
          vim.cmd("silent! write")
          vim.g.autosaving = false
        end
      end,
    })

    -- Highlight on yank
    vim.api.nvim_create_autocmd('TextYankPost', {
      desc = 'Highlight when yanking text',
      group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
      callback = function() vim.hl.on_yank() end,
    })

    -- Images open externally instead of as binary buffers (fzf, mini-files, gf, CLI)
    vim.api.nvim_create_autocmd("BufReadCmd", {
      pattern = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
      callback = function(ev)
        local path = vim.fn.fnamemodify(ev.match, ":p")
        if vim.fn.executable("imv") == 1 then
          -- Start on this image, with the rest of its folder to scroll through
          vim.system({ "imv", "-n", path, vim.fn.fnamemodify(path, ":h") }, { detach = true })
        else
          local _, err = vim.ui.open(path)
          if err then
            vim.notify("No image viewer found: " .. err, vim.log.levels.WARN)
          end
        end
        vim.schedule(function()
          pcall(vim.api.nvim_buf_delete, ev.buf, { force = true })
        end)
      end,
    })
  '';
}
