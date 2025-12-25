---@type vim.lsp.Config
return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl", "gosum" },
  root_markers = { "go.mod", "go.word", ".git" },
  capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    require('blink.cmp').get_lsp_capabilities({}, false)
  ),
};
