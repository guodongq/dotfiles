return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		keys = {
			{ "<leader>lm", "<cmd>Mason<cr>", desc = "Mason" },
			{ "<leader>lr", "<cmd>lua require('spectre').open()<cr>", desc = "Replace in files(Spectre)" },
		},
		config = function()
			local lspconfig = require("lspconfig")

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "x" }, "<F3>", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
					vim.keymap.set({ "n", "v" }, "<F4>", vim.lsp.buf.code_action, opts)
					-- vim.keymap.set("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, opts)
					-- vim.keymap.set("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder, opts)
					-- vim.keymap.set("n", "<leader>lwl", function()
					-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					-- end, opts)
				end,
			})
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
		config = true,
		keys = {
			{ "<leader>lo", "<cmd>SymbolsOutline<cr>", desc = "Outline" },
		},
	},
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		event = "LspAttach",
		opts = {},
	},
	{
		"nvim-pack/nvim-spectre",
		event = "BufReadPost",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
	},
}
