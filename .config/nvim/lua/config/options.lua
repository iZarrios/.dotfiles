vim.opt.number = true         -- can be replaced with nu
vim.opt.relativenumber = true -- can be replaced with rnu

vim.opt.spell = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Better spliting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

vim.opt.termguicolors = true

vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes:1"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "100"

vim.opt.clipboard = "unnamedplus"

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = {
    tab = "  ",
    trail = '~',
    nbsp = '␣',
    eol = '↲'
}


-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'
vim.o.winborder = 'rounded'

-- Enable cursor only in normal mode
vim.opt.cursorline = true
-- vim.cmd [[ au InsertLeave * set cursorline ]]
-- vim.cmd [[ au InsertEnter * set nocursorline ]]

vim.opt.autoread = true
