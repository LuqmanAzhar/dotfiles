-- [[ Configure LSP ]]

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("my-lsp-attach", { clear = true }),
	callback = function(args)
		local nmap = function(keys, func, desc)
			if desc then
				desc = "LSP: " .. desc
			end

			vim.keymap.set("n", keys, func, { buffer = args.buf, desc = desc })
		end

		nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

		nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
		nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
		nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")

		nmap("<leader>lD", vim.lsp.buf.type_definition, "Type [L][D]efinition")
		nmap("<leader>lds", require("telescope.builtin").lsp_document_symbols, "[L][D]ocument [S]ymbols")
		nmap("<leader>lws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[L][W]orkspace [S]ymbols")

		-- See `:help K` for why this keymap
		nmap("K", vim.lsp.buf.hover, "Hover Documentation")
		nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

		-- Lesser used LSP functionality
		nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
		nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
		nmap("<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, "[W]orkspace [L]ist Folders")

		-- Create a command `:Format` local to the LSP buffer
		vim.api.nvim_buf_create_user_command(args.buf, "Format", function(_)
			vim.lsp.buf.format()
		end, { desc = "Format current buffer with LSP" })
	end,
})

local servers = {
	lua_ls = {},
	stylua = {},
}

local capabilities = require("blink.cmp").get_lsp_capabilities()

local ensure_installed = {}
vim.list_extend(ensure_installed, {
	"lua-language-server",
	"stylua",
})

require("mason-lspconfig").setup()
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

for name, server in pairs(servers) do
	server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilties or {})
	vim.lsp.config(name, server)
	vim.lsp.enable(name)
end
