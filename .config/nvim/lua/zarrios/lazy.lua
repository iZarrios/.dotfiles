local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
    },
    {
        'ThePrimeagen/harpoon',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        lazy = false,
    },
    {
        "EdenEast/nightfox.nvim",
        name = 'nightfox',
        priority = 1000,
    },
    {
        'folke/tokyonight.nvim',
        name = 'tokyonight',
        priority = 1000,
    },
    {
        'ellisonleao/gruvbox.nvim',
        name = 'gruvbox',
        priority = 1000,
        config = true,
        opts = ...
    },
    {
        'nvim-treesitter/nvim-treesitter',
        tag = 'v0.9.2'
    },
    {
        'mbbill/undotree',
        priority = 1000
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        dependencies = {
            -- LSP Support
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Autocompletion
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',

            -- Snippets
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',
        }
    },
    {
        'nvim-lualine/lualine.nvim',
    },
    {
        'numToStr/Comment.nvim',
        priority = 1000,
    },
}

local opts = {}

require("lazy").setup(plugins, opts)
