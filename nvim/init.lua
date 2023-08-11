-- Early mapping of leader using the correct leader key for plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "


require("config.keymaps")
require("config.options")

require("plugins")

