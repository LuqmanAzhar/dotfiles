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
            "WhoIsSethDaniel/mason-tool-installer.nvim",

            { "j-hui/fidget.nvim", opts = {} },
            { "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } }, }, },
            },
            "saghen/blink.cmp",
        },
        config = function() require("plugins.config.lsp") end
    },
    -----------------------------------------------------------------------------
    -- Completions
    -----------------------------------------------------------------------------
   { -- Auto completion Blink
        "saghen/blink.cmp",
        event = "VimEnter",
        version = "1.*",
        dependencies = {
            -- Snippet Engine
            {
                "L3MON4D3/LuaSnip",
                version = "2.*",
                build = (function()
                    if vim.fn.has "win32" == 1 or vim.fn.executable "make" == 0 then return end
                    return "make install_jsregexp"
                end)(),
                dependencies = {
                    {
                      "rafamadriz/friendly-snippets",
                      config = function()
                        require("luasnip.loaders.from_vscode").lazy_load()
                      end,
                    },
                },
                opts = {},
            },
        },
        --- @module "blink.cmp"
        --- @type blink.cmp.Config
        opts = {
            keymap = {
                preset = "default",
                ["<CR>"] = { "accept", "fallback" },
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
				["<Up>"] = { "scroll_documentation_up", "fallback" },
				["<Down>"] = { "scroll_documentation_down", "fallback" },
				["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
            },
            appearance = {
                nerd_font_variant = "mono",
            },
            completion = {
                documentation = { auto_show = true, auto_show_delay_ms = 500 },
            },
            snippets = { preset = "luasnip" },
            fuzzy = { implementation = "lua" },
            signature = { enabled = true },
            sources = {
                default = { "lazydev", "lsp", "path", "snippets", "buffer" },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                },
            },
        }
    },
    -----------------------------------------------------------------------------
    -- Treesitter
    -----------------------------------------------------------------------------
    { -- Treesitter Text selections:<C-space>
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        build = ":TSUpdate",
        lazy = false,
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
    { -- Changing Surrounding Matched Pairs
        "kylechui/nvim-surround",
        version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function() require("nvim-surround").setup() end
    },
    -----------------------------------------------------------------------------
    -- Git
    -----------------------------------------------------------------------------
    { -- :G and interactively use git inside 
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
