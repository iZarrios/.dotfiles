local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("blink.cmp").get_lsp_capabilities({}, false)
)

-- remove formatting support from what we tell the server
capabilities.textDocument.formatting = nil
capabilities.textDocument.rangeFormatting = nil

---@type vim.lsp.Config
return {
  cmd = { 'ty', 'server' },
  filetypes = { "python" },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    'pyrightconfig.json',
    '.git',
    'ty.toml',
  },
  capabilities = capabilities,
  settings = {
    ty = {
      disableLanguageServices = false,
      diagnosticMode = 'workspace',
      inlayHints = {
        variableTypes = true,
      },
      completions = {
        autoImport = true,
      },
    },
  }
};
