let mapleader = " "

" call plug#begin('C:\Users\eyad4\AppData\Local\nvim\autoload\plugged')
call plug#begin()

" Syntax Highlighting ( TSInstall <LANUAGE>
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Plug 'scrooloose/nerdtree' 
Plug 'akinsho/toggleterm.nvim',{'tag' :'v2.*'}

" neovim LSP
Plug 'neovim/nvim-lspconfig' 
Plug 'ray-x/lsp_signature.nvim'

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

" git integration
Plug 'TimUntersberger/neogit'

" undotree
Plug 'mbbill/undotree'

" idk
Plug 'nvim-lua/plenary.nvim'
Plug 'ThePrimeagen/harpoon'

" Telescope
Plug 'nvim-telescope/telescope.nvim'

call plug#end()



hi Normal guibg=NONE ctermbg=NONE
" My Own Mappings

" Harpoon mappings
" nnoremap <leader>a <cmd>lua require('harpoon.mark').add_file()<cr>
" nnoremap <leader>e <cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>

" External configs
source ~/Development/.dotfiles/nvim/sets.vim
source ~/Development/.dotfiles/nvim/lua/me.lua
