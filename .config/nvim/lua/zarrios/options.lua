vim.opt.number = true
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("EXTERNAL_DRIVE_v42069") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.hlsearch = true 
vim.opt.incsearch = true

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "120"

vim.opt.clipboard = "unnamedplus"

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣', eol= '↲' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Enable cursor only in normal mode
vim.opt.cursorline = true
vim.cmd [[ au InsertLeave * set cursorline ]]
vim.cmd [[ au InsertEnter * set nocursorline ]]

-- Remove trailing whitespaces on write
vim.api.nvim_exec([[
  augroup TrimWhitespace
    autocmd!
    autocmd BufWritePre * :%s/\s\+$//e
  augroup END
]], false)
