-- This is Where all the Plugins get described and defined 
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    }
end
vim.opt.runtimepath:prepend(lazypath)

local status_ok, plugin = pcall(require, "lazy")
if not status_ok then return end

local plugins = {
    -----------------------------------------------------------------------------
    -- Look & feel
    -----------------------------------------------------------------------------
    {
        "catppuccin/nvim",
        name = "catpuccin",
        config = function() require("plugins.config.theme") end,
    },

    {
        "nvim-lualine/lualine.nvim",
        config = function() require("plugins.config.lualine") end,
        event = "VimEnter",
    },
    -----------------------------------------------------------------------------
    -- Navigation
    -----------------------------------------------------------------------------
    {
        "folke/which-key.nvim",  
        opts = { }
    },

    -----------------------------------------------------------------------------
    -- LSP
    -----------------------------------------------------------------------------

    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            'folke/neodev.nvim',
        },
        config = function() require("plugins.config.lsp") end
    },

    -----------------------------------------------------------------------------
    -- Completions
    -----------------------------------------------------------------------------
    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',

            -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',

            -- Adds a number of user-friendly snippets
            'rafamadriz/friendly-snippets',
        },
        config = function() require("plugins.config.cmp") end
    },

    -----------------------------------------------------------------------------
    -- Treesitter
    -----------------------------------------------------------------------------
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ":TSUpdate",
        config = function() require("plugins.config.treesitter") end,
    },

    -----------------------------------------------------------------------------
    -- Telescope
    -----------------------------------------------------------------------------
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- Fuzzy Finder Algorithm which requires local dependencies to be built.
            -- Only load if `make` is available. Make sure you have the system
            -- requirements installed.
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                -- NOTE: If you are having trouble with this installation,
                --       refer to the README for telescope-fzf-native for more instructions.
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },
        config = function() require("plugins.config.telescope") end,
    },

    -----------------------------------------------------------------------------
    -- Syntax, Languages & Code
    -----------------------------------------------------------------------------
    -- Comment lines/blocks
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function() require("nvim-surround").setup() end
    },

    -----------------------------------------------------------------------------
    -- Git
    -----------------------------------------------------------------------------
    { 'tpope/vim-fugitive' },
    { 'tpope/vim-rhubarb' },

}

plugin.setup(plugins)
