---@type vim.lsp.Config
return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl", "gosum" },
  root_markers = { "go.mod", "go.work", ".git" },
  capabilities = require("config.lsp_utils").make_capabilities(),
};
