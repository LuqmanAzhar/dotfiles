-- This is Where all the Plugins get described and defined 
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then return end

local plugins = {
    -----------------------------------------------------------------------------
    -- Look & feel
    -----------------------------------------------------------------------------
    { -- Visual Theme
        "catppuccin/nvim",
        name = "catpuccin",
        config = function() require("plugins.config.theme") end,
    },
    { -- Displaying Bottom 
        "nvim-lualine/lualine.nvim",
        dependencies = {"nvim-tree/nvim-web-devicons"},
        config = function() require("plugins.config.lualine") end,
        event = "VimEnter",
    },
    -----------------------------------------------------------------------------
    -- Navigation
    -----------------------------------------------------------------------------
    { -- Displays Key combinations live
        "folke/which-key.nvim",
        opts = {},-- Passes Empty Options to be merged with defaults
    },
    { -- Marks Improvement
        "chentoast/marks.nvim",
        event = "VeryLazy",
        opts = {}, -- Passes Empty Options to be merged with defaults
    },
    -----------------------------------------------------------------------------
    -- LSP
    -----------------------------------------------------------------------------
    { -- LSP Configuration & Plugins
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { "mason-org/mason.nvim", opts = {} },
            "mason-org/mason-lspconfig.nvim",

            { "j-hui/fidget.nvim", opts = {} },
            "saghen/blink.cmp",
        },
        config = function() require("plugins.config.lsp") end
    },
    -----------------------------------------------------------------------------
    -- Completions
    -----------------------------------------------------------------------------
    { -- Autocompletion
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
    { -- Treesitter Text selections:<C-space>
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        build = ":TSUpdate",
        config = function() require("plugins.config.treesitter") end,
    },

    -----------------------------------------------------------------------------
    -- Telescope
    -----------------------------------------------------------------------------
    { -- Pickers and primarily
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable "make" == 1
                end,
            },
        },
        config = function() require("plugins.config.telescope") end,
    },

    -----------------------------------------------------------------------------
    -- Syntax, Languages & Code
    -----------------------------------------------------------------------------
    { -- Comment lines/blocks
        "numToStr/Comment.nvim",
        lazy = false,
        config = function () require("Comment").setup() end
    },
    { -- Changing Sournding Matched Pairs
        "kylechui/nvim-surround",
        version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function() require("nvim-surround").setup() end
    },
    -----------------------------------------------------------------------------
    -- Git
    -----------------------------------------------------------------------------
    { -- :G and intractively use git inside 
        "tpope/vim-fugitive"
    },
    { -- :GBrowse opening the browser and Github Link
        "tpope/vim-rhubarb"
    },
    { -- :Adds signs in the gutter
        "lewis6991/gitsigns.nvim"
    },
    -----------------------------------------------------------------------------
    -- Obsidian.md
    -----------------------------------------------------------------------------
    { -- Configurations :<leader>o+ in MindPalace
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        event = {
            "BufReadPre " .. vim.fn.expand "~" .. "/MindPalace/**.md",
            "BufReadPre " .. vim.fn.expand "~" .. "/MindPalace/**/**.md",
            "BufNewFile " .. vim.fn.expand "~" .. "/MindPalace/**.md",
            "BufNewFile " .. vim.fn.expand "~" .. "/MindPalace/**/**.md",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
            "nvim-telescope/telescope.nvim"
        },
        config = function()
            require("plugins.config.obsidian")
        end,
    },
}
lazy.setup({ 
    spec = { plugins },
})
