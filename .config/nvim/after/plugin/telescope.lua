local builtin = require('telescope.builtin')

pcall(require('telescope').load_extension, 'fzf')

local opts = {
  noremap = true,
  silent = true
};

vim.keymap.set('n', '<C-p>', builtin.git_files, opts)
vim.keymap.set('n', '<leader>ff', function()
  builtin.find_files({ no_ignore = false, hidden = true })
end)

vim.keymap.set('n', '<leader>fg', function()
  require('telescope.builtin').live_grep({
    additional_args = function()
      return { "--hidden", "-g", "!.git/*" }
    end
  })
end)

vim.keymap.set('n', '<leader>fs', builtin.current_buffer_fuzzy_find, opts)
vim.keymap.set('n', '<leader>fh', builtin.help_tags, opts)
vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, opts)

-- I never use this
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, opts)
