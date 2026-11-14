-- Language support: LSP, formatting, linting and completion.
-- To add a language, extend the four tables below. Mason installs the servers and tools.

-- LSP servers, keyed by nvim-lspconfig name. Values are passed to vim.lsp.config().
local servers = {
	clangd = { cmd = { "clangd", "--background-index", "--clang-tidy" } },
	copilot = {}, -- next edit suggestions, see ai.lua
	gopls = {
		settings = {
			gopls = {
				analyses = { unusedparams = true },
				staticcheck = true,
				gofumpt = true,
			},
		},
	},
	jsonls = {},
	lua_ls = {},
	marksman = {},
	pyright = {},
	vtsls = {},
	yamlls = {},
}

-- Formatters (conform.nvim). Unlisted filetypes fall back to LSP formatting.
local formatters = {
	c = { "clang_format" },
	css = { "prettier" },
	go = { "gofumpt", "goimports" },
	javascript = { "prettier" },
	javascriptreact = { "prettier" },
	json = { "prettier" },
	lua = { "stylua" },
	markdown = { "prettier" },
	proto = { "buf" }, -- from Homebrew
	python = { "ruff_format" },
	typescript = { "prettier" },
	typescriptreact = { "prettier" },
	yaml = { "prettier" },
}

-- Linters (nvim-lint)
local linters = {
	go = { "revive" },
	javascript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	markdown = { "markdownlint" },
	python = { "ruff" },
	typescript = { "eslint_d" },
	typescriptreact = { "eslint_d" },
}

-- Mason packages for the formatters and linters above
local tools = {
	"clang-format",
	"eslint_d",
	"gofumpt",
	"goimports",
	"markdownlint",
	"prettier",
	"revive",
	"ruff",
	"stylua",
}

return {
	-- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			-- Nvim already maps grn, gra, gri, grr, grt, gO and K (:h lsp-defaults). K is mapped
			-- again because Nvim skips it when an ftplugin sets 'keywordprg' (Go, Python).
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					local function map(lhs, rhs, desc, method)
						if client and client:supports_method(method, event.buf) then
							vim.keymap.set("n", lhs, rhs, { buffer = event.buf, desc = "LSP: " .. desc })
						end
					end
					map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition", "textDocument/definition")
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration", "textDocument/declaration")
					map("gK", vim.lsp.buf.signature_help, "Signature Help", "textDocument/signatureHelp")
					map("grw", vim.lsp.buf.workspace_symbol, "Workspace Symbols", "workspace/symbol")
				end,
			})

			for name, config in pairs(servers) do
				vim.lsp.config(name, config)
			end
			local names = vim.tbl_keys(servers)
			require("mason-lspconfig").setup({ ensure_installed = names, automatic_enable = false })
			require("mason-tool-installer").setup({ ensure_installed = tools })
			vim.lsp.enable(names)
		end,
	},

	-- Neovim and plugin APIs for lua_ls while editing this config
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
			},
		},
	},

	-- Formatting, also on save
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		cmd = "ConformInfo",
		keys = {
			{ "<leader>f", function() require("conform").format({ async = true }) end, desc = "[F]ormat" },
		},
		opts = {
			formatters_by_ft = formatters,
			format_on_save = { timeout_ms = 1000, lsp_format = "fallback" },
		},
	},

	-- Linting on open and save
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("lint").linters_by_ft = linters
			vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
				group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
				callback = function() require("lint").try_lint() end,
			})
		end,
	},

	-- Completion
	{
		"saghen/blink.cmp",
		version = "1.*",
		event = { "InsertEnter", "CmdlineEnter" },
		opts = {
			keymap = {
				preset = "default",
				["<CR>"] = { "accept", "fallback" },
				-- Snippet jump first, then Sidekick's next edit suggestion, then a literal <Tab>.
				["<Tab>"] = {
					"snippet_forward",
					function() return require("sidekick").nes_jump_or_apply() end,
					"fallback",
				},
			},
			completion = { documentation = { auto_show = true, auto_show_delay_ms = 200 } },
			signature = { enabled = true },
		},
	},
}
