local capabilities = vim.lsp.protocol.make_client_capabilities()
-- wipe everything
capabilities.textDocument = {}
-- only enable formatting
capabilities.textDocument.formatting = { dynamicRegistration = true }
capabilities.textDocument.rangeFormatting = { dynamicRegistration = true, rangesSupport = true }


---@type vim.lsp.Config
return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
  capabilities = capabilities,
  init_options = {
    settings = {
      organizeImports = true,
      showSyntaxErrors = true,
      codeAction = {
        disableRuleComment = { enable = false },
        fixViolation = { enable = false },
      },
      lint = {
        enable = false,
      },
    },
  },
};
