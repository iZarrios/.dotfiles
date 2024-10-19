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
        lazy = false,
    },
    {
        'ThePrimeagen/harpoon',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        lazy = false,
    },
    {
        "j-hui/fidget.nvim",
        opts = {
            -- options
        },
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = true,
    },
    {
        "EdenEast/nightfox.nvim",
        name = 'nightfox',
        priority = 1000,
        lazy = true,
    },
    {
        'folke/tokyonight.nvim',
        name = 'tokyonight',
        priority = 1000,
        lazy = true,
    },
    {
        'ellisonleao/gruvbox.nvim',
        name = 'gruvbox',
        priority = 1000,
        config = true,
        opts = ...,
        lazy = true,
    },
    {
        'nvim-treesitter/nvim-treesitter',
    },
    {
        'mbbill/undotree',
        -- priority = 1000,
        -- lazy = true,
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
        lazy = true,
        priority = 1000,
    },
    {
        "github/copilot.vim",
        -- lazy = true,
        -- priority = 1000,
    },
    {
        'nvim-tree/nvim-web-devicons',
        lazy = true,
        priorty = 1000,
    },
}

local opts = {}

require("lazy").setup(plugins, opts)
