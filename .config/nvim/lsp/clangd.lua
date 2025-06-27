return {
    cmd = { 'clangd', '--background-index', '--clang-tidy' },
    -- custom on attach function for clangd
    on_attach = function(_, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        -- c/cpp go to .h/.cpp
        vim.keymap.set("n", "<A-o>", "<cmd>ClangdSwitchSourceHeader<CR>", opts)
    end
};
