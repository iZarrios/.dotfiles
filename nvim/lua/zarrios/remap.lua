vim.g.mapleader = " "

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("i", "jj", "<ESC>", opts)
vim.keymap.set("i", "kj", "<ESC>", opts)
vim.keymap.set("n", "gV", "`[v`]")

vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", opts)

vim.keymap.set("n", "<leader>g", "<cmd>Neogit<cr>", opts)


vim.keymap.set("n", "<leader>g", "<cmd>Neogit<cr>", opts)
