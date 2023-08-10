local lsp = require('lsp-zero')

lsp.preset({
    manage_nvim_cmp =  {
        set_sources = 'lsp',
        set_basic_mappings = true,
        set_extra_mappings = false,
        use_luasnip = true,
        set_format = true,
        documentation_window = true,
    }
})

lsp.on_attach(function(_, bufnr)
    local opts = {buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() print(bufnr) end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    -- These are the Lsp helper tools
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leadar>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    -- Legacy Reasons
    vim.keymap.set("n", "<F2>", function() vim.lsp.buf.rename() end, opts)
end)

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
require('lspconfig').sourcekit.setup {
    cmd = {"/usr/bin/sourcekit-lsp"}
}

lsp.setup()

local cmp = require("cmp")
local cmp_select = {behavior = cmp.SelectBehavior.select}
local cmp_action = lsp.cmp_action()

cmp.setup({
    mapping = {
        -- Style Experiment Is it better tab or movement
        ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
        ['<Tab>'] = cmp_action.tab_complete(),
        ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
    }
})

