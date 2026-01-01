---@type vim.lsp.Config
return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
  single_file_support = true,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
        }
      },
      diagnostics = {
        globals = { 'vim', 'require' },
      },
      telemetry = { enable = false },
    },
  },
  capabilities = require("config.lsp_utils").make_capabilities(),
};
