return {
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
        -- LSP Support
        'neovim/nvim-lspconfig',

        -- Autocompletion
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',

        -- Snippets
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets',
    },
    opts = function()
        local lsp = require("lsp-zero")
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

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

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


    end
};
