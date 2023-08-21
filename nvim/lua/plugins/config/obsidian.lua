vim.keymap.set("n", "gf", function()
    if require("obsidian").util.cursor_on_markdown_link() then
        return "<cmd>ObsidianFollowLink<CR>"
    else
        return "gf"
    end

end, { noremap = false, expr = true })


require("obsidian").setup {
    dir = "~/MindPalace",  -- no need to call 'vim.fn.expand' here
    mappings = { }
}
