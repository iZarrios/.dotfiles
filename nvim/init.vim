let mapleader = " "
let g:neoformat_try_node_exe = 1

" call plug#begin('C:\Users\eyad4\AppData\Local\nvim\autoload\plugged')
call plug#begin()


" Syntax Highlighting ( TSInstall <LANUAGE>
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'nvim-treesitter/playground'
" Plug 'theprimeagen/tree-navigation'

"kitty syntax Highlighting
Plug 'fladson/vim-kitty'

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
Plug  'L3MON4D3/LuaSnip'
Plug  'saadparwaiz1/cmp_luasnip'

" Commenting
Plug 'tpope/vim-commentary'


" Format
" Plug 'mhartington/formatter.nvim'
Plug 'sbdchd/neoformat'

" Color Scheme
" Plug 'joshdick/onedark.vim'
" Plug 'projekt0n/github-nvim-theme'
" Plug 'https://github.com/morhetz/gruvbox'
Plug 'folke/tokyonight.nvim',{'branch' :'main'}

Plug 'TimUntersberger/neogit'

" easy motion
Plug 'easymotion/vim-easymotion'

" undotree
Plug 'mbbill/undotree'

" idk
Plug 'nvim-lua/plenary.nvim'

" Telescope
Plug 'nvim-telescope/telescope.nvim'

call plug#end()


" colorscheme gruvbox 




" My Own Mappings
inoremap kj <ESC>
inoremap jj <ESC>

" NerdTree Config
" nnoremap <leader>n :NERDTreeFocus<CR>
" nnoremap <C-n> :NERDTree<CR>
" nnoremap <C-b> :NERDTreeToggle<CR>
" nnoremap <C-f> :NERDTreeFind<CR>

" Telescope Config
 
" Find files using Telescope command-line sugar.
"nnoremap <leader>ff <cmd>Telescope find_files<cr>
"nnoremap <leader>fg <cmd>Telescope live_grep<cr>
"nnoremap <leader>fb <cmd>Telescope buffers<cr>
"nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
"nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <C-p> <cmd>lua require('telescope.builtin').git_files()<CR>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" External configs
source ~/Development/.dotfiles/nvim/sets.vim
source ~/Development/.dotfiles/nvim/lua/me.lua
