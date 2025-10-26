local border = "rounded"

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
  float = {
    border = border,
    source = "always",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    }
  }
})

vim.lsp.enable('lua_ls')
vim.lsp.enable('jdtls')

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local buf = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    
    if client.server_capabilities.semanticTokensProvider then
      vim.lsp.semantic_tokens.start(buf, client.id)
    end
    
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
    end
    
    vim.bo[buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    
    vim.keymap.set("i", "<C-n>", function()
      if vim.fn.pumvisible() == 1 then
        return "<C-n>"
      else
        return "<C-x><C-o>"
      end
    end, { buffer = buf, expr = true, desc = "Next completion" })
    
    vim.keymap.set("i", "<C-p>", "<C-p>", { buffer = buf, desc = "Previous completion" })
    vim.keymap.set("i", "<C-y>", "<C-y>", { buffer = buf, desc = "Accept completion" })
    vim.keymap.set("i", "<C-e>", "<C-e>", { buffer = buf, desc = "Close completion" })
    
    vim.keymap.set("i", "<CR>", function()
      if vim.fn.pumvisible() == 1 then
        return "<C-y>"
      else
        return "<CR>"
      end
    end, { buffer = buf, expr = true, desc = "Accept or newline" })
    
    vim.keymap.set("i", "<Tab>", function()
      if vim.fn.pumvisible() == 1 then
        return "<C-n>"
      else
        return "<Tab>"
      end
    end, { buffer = buf, expr = true, desc = "Tab or next" })
    
    vim.keymap.set("i", "<S-Tab>", function()
      if vim.fn.pumvisible() == 1 then
        return "<C-p>"
      else
        return "<S-Tab>"
      end
    end, { buffer = buf, expr = true, desc = "Shift-Tab or previous" })
    
    local opts = { buffer = buf, silent = true }
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    
    if client.name == "jdtls" then
      vim.keymap.set("n", "<leader>ju", "<cmd>lua vim.lsp.buf.execute_command({command = 'java.projectConfiguration.update', arguments = {vim.uri_from_bufnr(0)}})<CR>",
        vim.tbl_extend("force", opts, { desc = "Update project configuration" }))
      vim.keymap.set("n", "<leader>jc", "<cmd>lua vim.lsp.buf.execute_command({command = 'java.clean.workspace'})<CR>",
        vim.tbl_extend("force", opts, { desc = "Clean workspace" }))
    end
  end,
})

vim.cmd("set completeopt=menu,menuone,noselect")

vim.opt.updatetime = 300
vim.opt.timeoutlen = 500

vim.api.nvim_create_autocmd("TextChangedI", {
  pattern = "*",
  callback = function()
    -- Ignorar em buffers do Telescope
    local buftype = vim.bo.buftype
    if buftype == "prompt" or buftype == "nofile" then
      return
    end
    
    if vim.fn.pumvisible() == 0 then
      local col = vim.fn.col('.') - 1
      local line = vim.fn.getline('.')
      local char_before = line:sub(col, col)
      
      -- Trigger após ponto (.) ou após 2+ caracteres
      if char_before:match('[%w_]') then
        local word_start = line:sub(1, col):match('([%w_]+)')
        if word_start and #word_start >= 2 then
          vim.defer_fn(function()
            if vim.fn.pumvisible() == 0 and vim.api.nvim_get_mode().mode == 'i' then
              vim.api.nvim_feedkeys(
                vim.api.nvim_replace_termcodes('<C-x><C-o>', true, false, true),
                'n',
                false
              )
            end
          end, 100)
        end
      elseif char_before == '.' then
        vim.defer_fn(function()
          if vim.fn.pumvisible() == 0 and vim.api.nvim_get_mode().mode == 'i' then
            vim.api.nvim_feedkeys(
              vim.api.nvim_replace_termcodes('<C-x><C-o>', true, false, true),
              'n',
              false
            )
          end
        end, 50)
      end
    end
  end
})
