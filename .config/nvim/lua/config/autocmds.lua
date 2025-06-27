vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
        local bufnr = event.buf
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
    end,
})
