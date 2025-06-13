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
    },
})


local cmp_select = { behavior = cmp.SelectBehavior.Select }


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
-- SRC: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
lspcfg.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT',
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      diagnostics = { globals = { 'vim', 'require' } },
      telemetry = { enable = false },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
        }
      }
    })
  end,
  settings = {
    Lua = {}
  }
}

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
    -- virtual lines are like virtual_text but more `fancy`
    -- too much lines jumps when I enable virtual_lines, not worth it
    virtual_lines = false,
    virtual_text = true,
    update_in_insert = false,
})
