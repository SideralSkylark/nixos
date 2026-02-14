return {
  cmd = { "lua-language-server" },
  root_markers = { ".git", ".luarc.json", "init.lua" },
  filetypes = { "lua" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
}
