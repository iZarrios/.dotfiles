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

-- user commands
local RemoveComments = function()
    local ts         = vim.treesitter
    local bufnr      = vim.api.nvim_get_current_buf()
    local ft         = vim.bo[bufnr].filetype
    local lang       = ts.language.get_lang(ft) or ft

    local ok, parser = pcall(ts.get_parser, bufnr, lang)
    if not (ok and parser) then return vim.notify("No parser for " .. ft, vim.log.levels.WARN) end

    local tree   = parser:parse()[1]
    local root   = tree:root()
    local query  = ts.query.parse(lang, "(comment) @comment")

    local ranges = {}
    for _, node in query:iter_captures(root, bufnr, 0, -1) do
        table.insert(ranges, { node:range() })
    end

    table.sort(ranges, function(a, b)
        if a[1] == b[1] then return a[2] < b[2] end
        return a[1] > b[1]
    end)

    for _, r in ipairs(ranges) do
        vim.api.nvim_buf_set_text(bufnr, r[1], r[2], r[3], r[4], {})
    end
end
vim.api.nvim_create_user_command("RemoveComments", RemoveComments, {})


vim.api.nvim_create_user_command("TrimWhitespaceSetup", function()
  vim.api.nvim_exec2([[
    augroup TrimWhitespace
      autocmd!
      autocmd BufWritePre * :%s/\s\+$//e | :%s/\r//e
    augroup END
  ]], {})
end, {})
