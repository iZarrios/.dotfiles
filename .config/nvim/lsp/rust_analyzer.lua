return {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    capabilities = vim.tbl_deep_extend(
        'force',
        vim.lsp.protocol.make_client_capabilities(),
        require('blink.cmp').get_lsp_capabilities({}, false)
    ),
    root_markers = { "Cargo.toml"},
};
