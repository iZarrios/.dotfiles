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
  capabilities = require("config.lsp_utils").make_capabilities_no_formatting(),
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
