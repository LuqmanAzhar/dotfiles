return {
    "catppuccin/nvim",
    priority = 1000,
    config = function()
        flavour = 'mocha'
        vim.cmd.colorscheme  'catppuccin'
    end
}
