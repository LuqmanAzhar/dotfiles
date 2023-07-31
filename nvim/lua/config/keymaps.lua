-- Remapping "project view" 
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Vscode Moving Lines but Vim like
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Page Up and down auto centering
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Don't Lose buffer when pasting from register
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Leader Yank To Yank to Clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Cut to Clipboard
vim.keymap.set("n", "<leader>x", "\"+d")
vim.keymap.set("v", "<leader>x", "\"+d")
vim.keymap.set("n", "<leader>X", "\"+D")

-- Delete to not affect p buffer
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")
vim.keymap.set("n", "<leader>D", "\"_D")
