vim.lsp.enable({
    -- "gopls",
    "lua_ls",
    "clangd",
    -- "pyright",
    "ruff",
    "ty",
    "rust_analyzer",
    -- "ts_ls",
})


-- commenting this as when using rust it clutters the messages box
-- -- vim.api.nvim_create_autocmd('LspProgress', {
-- --   callback = function(ev)
-- --     local client = vim.lsp.get_client_by_id(ev.data.client_id)
-- --     local value = ev.data.params.value
-- --
-- --     if not client or not value then return end
-- --
-- --     -- CUSTOMIZE YOUR MESSAGE HERE
-- --     local icon = value.kind == 'end' and '✅' or '⏳'
-- --     local client_name = client.name
-- --     local msg = value.message or (value.kind == 'end' and 'Finished' or 'In progress...')
-- --     local display_text = string.format("%s [%s] %s", icon, client_name, msg)
-- --
-- --     vim.api.nvim_echo({ { display_text } }, false, {
-- --       id = 'lsp.' .. ev.data.client_id,
-- --       kind = 'progress',
-- --       source = 'vim.lsp',
-- --       title = value.title,
-- --       status = value.kind ~= 'end' and 'running' or 'success',
-- --       percent = value.percentage,
-- --     })
-- --   end,
-- -- })

vim.diagnostic.config({
    underline = true,
    signs = true,
    -- virtual lines are like virtual_text but more `fancy`
    -- too much lines jumps when I enable virtual_lines, not worth it
    virtual_lines = false,
    virtual_text = true,
    update_in_insert = false,
})

