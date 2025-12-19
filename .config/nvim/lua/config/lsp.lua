vim.lsp.enable({
    "gopls",
    "lua_ls",
    "clangd",
    "pyright",
    "ruff",
    "ty",
    "rust_analyzer",
    "ts_ls",
})


vim.diagnostic.config({
    underline = true,
    signs = true,
    -- virtual lines are like virtual_text but more `fancy`
    -- too much lines jumps when I enable virtual_lines, not worth it
    virtual_lines = false,
    virtual_text = true,
    update_in_insert = false,
})

