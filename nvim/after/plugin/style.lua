require('catppuccin').setup {
	flavour = 'mocha'
}
vim.cmd.colorscheme 'catppuccin'

require('lualine').setup {
    options = {
        icons_enabled = false,
        theme = 'catppuccin',
        component_separators = '|',
        section_separators = ''
    }
}

