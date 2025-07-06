---@diagnostic disable: inject-field

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro'

vim.o.background = "dark"

vim.g.copilot_enabled = false


-- remove trailing whitespaces on write
vim.api.nvim_exec2([[
  augroup TrimWhitespace
    autocmd!
    autocmd BufWritePre * :%s/\s\+$//e | :%s/\r//e
  augroup END
]], {})
