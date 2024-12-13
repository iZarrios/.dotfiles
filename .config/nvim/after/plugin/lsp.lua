local lsp = require("lsp-zero")
local lspcfg = require("lspconfig")
local cmp = require('cmp')

lsp.on_attach(function(_, bufnr)
    local opts = { buffer = bufnr, remap = false, silent = true }


    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementations() end, opts)
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)

    -- vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)

    vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover()
    end, opts)

    vim.keymap.set("n", "H", function()
        -- open diagnostics floating window
        vim.diagnostic.open_float()
    end, opts)

    -- -- I am probably not gonna use this like ever
    -- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)

    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, opts)
end)

-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
    handlers = {
        lsp.default_setup,
        lua_ls = function()
            local lua_opts = lsp.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
    },
})


local cmp_select = { behavior = cmp.SelectBehavior.Select }


lsp.configure('lua_ls', {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' },
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    -- Make the server aware of Neovim runtime files
                    unpack(vim.api.nvim_get_runtime_file('', true)),
                    '{3rd}/luv/library',
                },
            },
            completion = {
                callSnipper = 'Replace',
            },
        },
    },
})


lspcfg.clangd.setup {
    cmd = { 'clangd', '--background-index', '--clang-tidy' },
    -- custom on attach function for clangd
    on_attach = function(_, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        -- c/cpp go to .h/.cpp
        vim.keymap.set("n", "<A-o>", "<cmd>ClangdSwitchSourceHeader<CR>", opts)
    end
}

lspcfg.pyright.setup {}
lspcfg.ruff.setup {}
lspcfg.rust_analyzer.setup {}
lspcfg.gopls.setup {}
lspcfg.ts_ls.setup {}

cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip', keyword_length = 2 },
        { name = 'buffer',  keyword_length = 3 },
    },
    formatting = lsp.cmp_format(),
    mapping = cmp.mapping.preset.insert({
        ['<tab>'] = nil,
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
})


vim.diagnostic.config({
    underline = true,
    signs = true,
    virtual_text = true,
    update_in_insert = false,
})
