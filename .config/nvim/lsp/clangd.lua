-- SRC: https://clangd.llvm.org/extensions.html#switch-between-sourceheader
-- SRC: https://github.com/neovim/nvim-lspconfig/blob/6bba673aa8993eceec233be17b42ddfb9540794b/lsp/clangd.lua
local function switch_source_header(bufnr)
  local method_name = 'textDocument/switchSourceHeader'
  local client = vim.lsp.get_clients({ bufnr = bufnr, name = 'clangd' })[1]
  if not client then
    return vim.notify(('method %s is not supported by any servers active on the current buffer'):format(method_name))
  end
  local params = vim.lsp.util.make_text_document_params(bufnr)

  --- @diagnostic disable-next-line: param-type-mismatch
  client:request(method_name, params, function(err, result)
    if err then
      error(tostring(err))
    end
    if not result then
      vim.notify('corresponding file cannot be determined')
      return
    end
    vim.cmd.edit(vim.uri_to_fname(result))
  end, bufnr)
end

return {
    cmd = { 'clangd', '--background-index', '--clang-tidy' },
    root_markers = {
        '.clangd',
        '.clang-tidy',
        '.clang-format',
        'compile_commands.json',
        'compile_flags.txt',
        '.git',
    },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
    -- custom on attach function for clangd
    on_attach = function(_, bufnr)
        vim.api.nvim_buf_create_user_command(bufnr, 'LspClangdSwitchSourceHeader', function()
            switch_source_header(bufnr)
        end, { desc = 'Switch between source/header' })

        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "<A-o>", "<cmd>LspClangdSwitchSourceHeader<CR>", opts)
    end,
    capabilities = vim.tbl_deep_extend(
        'force',
        vim.lsp.protocol.make_client_capabilities(),
        require('blink.cmp').get_lsp_capabilities({}, false)
    ),

};
