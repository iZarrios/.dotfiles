---@diagnostic disable: inject-field

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro'

vim.o.background = "dark"

if vim.g.neovide then
  -- vim.o.guifont = "Iosevka,STHeiti:h16"
  vim.g.neovide_scroll_animation_length = 0.1
  vim.g.neovide_input_use_logo = false -- true on macOS
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_vfx_mode = ""
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_theme = "dark"
  vim.g.neovide_confirm_quit = true
  vim.g.neovide_cursor_antialiasing = true
end

vim.g.copilot_enabled = false
