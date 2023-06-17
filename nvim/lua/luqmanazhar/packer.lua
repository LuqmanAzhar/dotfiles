-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.1',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- This for the current Style and theme
  use { "catppuccin/nvim", as = "catppuccin" }

  -- This is for syntax highlighting it does a tree on the
  use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

  -- harpoon "File Quick Switch with caching of cursor placement per project" 
  -- Really good for maintaining the jump list integrity <C-i> <C-o>
  use ('theprimeagen/harpoon')

  -- TESTING Undo Tree 
  use ('mbbill/undotree')

  -- git integration allows more ide like git adding
  use ('tpope/vim-fugitive')

  -- LSP Integration (Language Server Protocol)
  use {
	'VonHeikemen/lsp-zero.nvim',
	branch = 'v2.x',
	requires = {
		-- LSP Support
		{'neovim/nvim-lspconfig'},             -- Required
		{                                      -- Optional
		  	'williamboman/mason.nvim',
		  	run = function()
				pcall(vim.cmd, 'MasonUpdate')
		  	end,
	  	},
	  {'williamboman/mason-lspconfig.nvim'}, -- Optional

	  -- Autocompletion
	  {'hrsh7th/nvim-cmp'},     -- Required
	  {'hrsh7th/cmp-nvim-lsp'}, -- Required
	  {'L3MON4D3/LuaSnip'},     -- Required
  	}
  }

  -- Allows Commneting Motions with  :h comment.config
  use { 'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
    }

  end)
