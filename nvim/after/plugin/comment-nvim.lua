local api = require('Comment.api')

local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)

-- Enables Vscode like Commenting of code
vim.keymap.set("n", "<C-/>", api.toggle.linewise.current)
vim.keymap.set("i", "<C-/>", api.toggle.linewise.current)
vim.keymap.set('v', '<C-/>', function()
            vim.api.nvim_feedkeys(esc, 'nx', false)
            api.toggle.linewise(vim.fn.visualmode())
        end)

-- Also Has alternate k for comment
vim.keymap.set("n", "<C-k>", api.toggle.linewise.current)
vim.keymap.set("i", "<C-k>", api.toggle.linewise.current)
vim.keymap.set('v', '<C-k>', function()
            vim.api.nvim_feedkeys(esc, 'nx', false)
            api.toggle.linewise(vim.fn.visualmode())
        end)
