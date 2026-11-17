-- Language support: LSP, formatting and linting.

-- LSP servers, keyed by nvim-lspconfig name. Values are passed to vim.lsp.config().
local servers = {
	clangd = { cmd = { "clangd", "--background-index", "--clang-tidy" } },
	copilot = {}, -- next edit suggestions, see ai.lua
	gopls = {
		settings = {
			gopls = {
				staticcheck = true,
				gofumpt = true,
			},
		},
	},
	marksman = {}, -- Markdown links, outline and table of contents
	pyright = {},
}

return {
	-- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Load first, so servers start with its completion capabilities.
			"saghen/blink.cmp",
			{ "mason-org/mason.nvim", opts = {} },
			"mason-org/mason-lspconfig.nvim",
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				opts = {
					ensure_installed = {
						"clang-format",
						"prettier",
						"gofumpt",
						"goimports",
						"markdownlint",
						"ruff",
					},
				},
			},
		},
		config = function()
			-- Keep native LSP mappings; add only the conventional definition shortcut.
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client:supports_method("textDocument/definition", event.buf) then
						vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
							buffer = event.buf,
							desc = "LSP: Go to definition",
						})
					end
				end,
			})

			for name, config in pairs(servers) do
				vim.lsp.config(name, config)
			end
			local server_names = vim.tbl_keys(servers)
			-- Only enable this list, not every server already installed in Mason.
			require("mason-lspconfig").setup({ ensure_installed = server_names, automatic_enable = false })
			vim.lsp.enable(server_names)
		end,
	},

	-- Formatting, also on save. Unlisted filetypes fall back to LSP.
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		cmd = "ConformInfo",
		keys = {
			{ "<leader>f", function() require("conform").format({ async = true }) end, desc = "Format" },
		},
		opts = {
			default_format_opts = { lsp_format = "fallback" },
			format_on_save = true,
			formatters_by_ft = {
				c = { "clang_format" },
				cpp = { "clang_format" },
				go = { "goimports", "gofumpt" },
				markdown = { "prettier" },
				proto = { "buf" }, -- from Homebrew
				python = { "ruff_format" },
			},
		},
	},

	-- Linting on open and save
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				markdown = { "markdownlint" },
				python = { "ruff" },
			}
			vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
				group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
				-- try_lint expects linter names, not the autocmd event table.
				callback = function() lint.try_lint() end,
			})
		end,
	},
}
