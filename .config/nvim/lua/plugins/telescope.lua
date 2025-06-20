return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    lazy = false,
    opts = function()
        local builtin = require('telescope.builtin')

        pcall(require('telescope').load_extension, 'fzf')

        local opts = {
            noremap = true,
            silent = true
        };

        vim.keymap.set('n', '<C-p>', builtin.git_files, opts)
        vim.keymap.set('n', '<leader>ff', function()
            -- I do it like this in case there is a specific theme I want to load in the future
            local tbl = {} -- require('telescope.themes').get_dropdown({})
            tbl.no_ignore = false
            tbl.hidden = true
            builtin.find_files(tbl)
        end)

        vim.keymap.set('n', '<leader>fg', function()
            require('telescope.builtin').live_grep({
                additional_args = function()
                    return { "--hidden", "-g", "!.git/*" }
                end
            })
        end)

        vim.keymap.set('n', '<leader>fs', builtin.current_buffer_fuzzy_find, opts)
        vim.keymap.set('n', '<leader>ss', builtin.lsp_document_symbols, opts)
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, opts)
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") });
        end)
        vim.keymap.set('n', '<leader>fd', builtin.diagnostics, opts)

        -- I never use this
        -- vim.keymap.set('n', '<leader>fb', builtin.buffers, opts)
    end
};
