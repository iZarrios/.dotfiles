let mapleader = " "

" call plug#begin('C:\Users\eyad4\AppData\Local\nvim\autoload\plugged')
call plug#begin()

" Syntax Highlighting ( TSInstall <LANUAGE>
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Plug 'scrooloose/nerdtree' 
Plug 'akinsho/toggleterm.nvim',{'tag' :'v2.*'}
" neovim LSP
Plug 'neovim/nvim-lspconfig' 

" LSP autocomplete
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" Commenting
Plug 'tpope/vim-commentary'

" Status line
Plug 'nvim-lualine/lualine.nvim'

" Color Scheme
Plug 'https://github.com/morhetz/gruvbox'

Plug 'TimUntersberger/neogit'

" undotree
Plug 'mbbill/undotree'

" idk
Plug 'nvim-lua/plenary.nvim'
Plug 'ThePrimeagen/harpoon'

" Telescope
Plug 'nvim-telescope/telescope.nvim'

" Prettier
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'MunifTanjim/prettier.nvim'

" Plug 'williamboman/mason.nvim'
call plug#end()



colorscheme gruvbox 
hi Normal guibg=NONE ctermbg=NONE
" My Own Mappings

" not sure about this
nnoremap n nzz
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz

inoremap kj <ESC>
inoremap jj <ESC>

" nnoremap <leader>g 


" Harpoon mappings
nnoremap <leader>a <cmd>lua require('harpoon.mark').add_file()<cr>
nnoremap <leader>e <cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>

" External configs
source ~/Development/.dotfiles/nvim/sets.vim
source ~/Development/.dotfiles/nvim/lua/me.lua
