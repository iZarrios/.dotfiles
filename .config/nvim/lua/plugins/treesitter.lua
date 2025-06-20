return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = {
        ensure_installed = { "c", "lua", "comment" },
        -- A list of parser names, or "all"
        -- Install parsers synchronously (only applied to `ensure_installed`)
        -- sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        highlight = {
            -- `false` will disable the whole extension
            enable = true,

            disalbe = function(_, buf)
                local max_file_size = 100 * 1024 -- 100KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_file_size then
                    return true
                end
            end,

            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = true,
        },
    }
};
