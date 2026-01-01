local M = {}

function M.make_capabilities()
  return vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    require('blink.cmp').get_lsp_capabilities({}, false)
  )
end

function M.make_capabilities_no_formatting()
  local capabilities = M.make_capabilities()
  capabilities.textDocument.formatting = nil
  capabilities.textDocument.rangeFormatting = nil
  return capabilities
end

function M.make_formatting_only_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument = {}
  capabilities.textDocument.formatting = { dynamicRegistration = true }
  capabilities.textDocument.rangeFormatting = { dynamicRegistration = true, rangesSupport = true }
  return capabilities
end

return M
