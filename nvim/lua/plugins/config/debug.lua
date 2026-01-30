local dap = require("dap")

require("mason-nvim-dap").setup({
	automatic_installation = true,
    handlers = {},
    ensure_installed = {}
})

local keymap = vim.keymap

local function set(mode, keys, func, desc)
    if desc then
        desc = "DAP: " .. desc
    end
    keymap.set(mode, keys, func, {desc = desc})
end

set("n", "<leader>b", function() require("dap").set_breakpoint() end, "Set [B]reakpoint")
