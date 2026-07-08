-- LSP Configuration
-- To add a new language server: append to `opts.servers`.
-- To add extra mason tools (formatters/linters): append to `opts.tools`.
-- Server executable names are auto-added to the mason install list.

local M = {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		{
			"stevearc/aerial.nvim",
			cmd = { "AerialToggle" },
			opts = {},
			dependencies = {
				"nvim-treesitter/nvim-treesitter",
				{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
			},
		},
	},
}

M.opts = {
	-- LSP servers: key = server name, value = lspconfig settings.
	servers = {
		gopls = {
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			settings = {
				gopls = {
					hints = {
						assignVariableTypes = true,
						compositeLiteralFields = true,
						compositeLiteralTypes = true,
						constantValues = true,
						functionTypeParameters = true,
						parameterNames = true,
						rangeVariableTypes = true,
					},
					analyses = { unusedparams = true },
					staticcheck = true,
					gofumpt = true,
				},
			},
		},
		pyright = {
			settings = {
				python = {
					analysis = {
						autoSearchPaths = true,
						diagnosticMode = "openFilesOnly",
						useLibraryCodeForTypes = true,
					},
				},
			},
		},
		ts_ls = {
			filetypes = {
				"javascript", "javascriptreact", "javascript.jsx",
				"typescript", "typescriptreact", "typescript.tsx",
			},
		},
		clangd = {
			cmd = { "clangd", "--background-index", "--clang-tidy" },
			filetypes = { "c", "cpp", "objc", "objcpp" },
		},
		jdtls = {
			cmd = { "jdtls" },
			filetypes = { "java" },
		},
		lua_ls = {
			on_init = function(client)
				if not client.workspace_folders then return end
				local path = client.workspace_folders[1].name
				if path ~= vim.fn.stdpath("config")
					and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
				then return end
				client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
					runtime = {
						version = "LuaJIT",
						path = { "lua/?.lua", "lua/?/init.lua" },
					},
					workspace = {
						checkThirdParty = false,
						library = vim.tbl_extend("force", vim.api.nvim_get_runtime_file("", true), {
							"${3rd}/luv/library",
							"${3rd}/busted/library",
						}),
					},
				})
			end,
		},
		marksman = {},
		jsonls   = {},
		yamlls   = {},
	},
	-- Extra mason tools to install (formatters, linters).
	-- LSP server names from `servers` are appended automatically.
	tools = {
		"stylua", "prettier",
		"gofumpt", "goimports",
		"clang-format", "isort", "black",
		"eslint", "ruff", "revive", "markdownlint",
	},
}

M.config = function(_, opts)
	-- LSP keybindings: set up on every buffer that attaches a server
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
		callback = function(event)
			local map = function(keys, func, desc, mode)
				vim.keymap.set(mode or "n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
			end

			-- Navigation
			map("gd",  vim.lsp.buf.definition,      "[G]oto [D]efinition")
			map("gD",  vim.lsp.buf.declaration,     "[G]oto [D]eclaration")
			map("gt",  vim.lsp.buf.type_definition, "[G]oto [T]ype Definition")
			map("gi",  vim.lsp.buf.implementation,  "[G]oto [I]mplementation")
			map("gr",  vim.lsp.buf.references,      "[G]oto [R]eferences")
			-- Symbols
			map("gO",  vim.lsp.buf.document_symbol,  "Document Symbols")
			map("gW",  vim.lsp.buf.workspace_symbol, "Workspace Symbols")
			-- Actions
			map("grn", vim.lsp.buf.rename,          "[R]ename")
			map("ga",  vim.lsp.buf.code_action,     "Code Actions", { "n", "x" })
			map("go",  "<cmd>AerialToggle!<cr>",    "Outline")

			local client = vim.lsp.get_client_by_id(event.data.client_id)

			-- Document highlight on cursor hold (per-buffer augroup, no cross-buffer conflict)
			if client and client:supports_method("textDocument/documentHighlight", event.buf) then
				local hl_group = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = event.buf, group = hl_group,
					callback = vim.lsp.buf.document_highlight,
				})
				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = event.buf, group = hl_group,
					callback = vim.lsp.buf.clear_references,
				})
				-- Clean up this buffer's autocmds when server detaches
				vim.api.nvim_create_autocmd("LspDetach", {
					buffer = event.buf,
					group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
					callback = function()
						vim.lsp.buf.clear_references()
						vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event.buf })
					end,
				})
			end

			-- Inlay hints toggle
			if client and client:supports_method("textDocument/inlayHint", event.buf) then
				map("<leader>th", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
				end, "Toggle Hints")
			end
		end,
	})

	-- Configure and enable all servers defined in opts.servers
	for name, config in pairs(opts.servers) do
		vim.lsp.config(name, config)
		vim.lsp.enable(name)
	end

	-- Install server executables + extra tools via mason-tool-installer
	local tools = vim.list_extend(vim.deepcopy(opts.tools), vim.tbl_keys(opts.servers))
	require("mason-tool-installer").setup({ ensure_installed = tools })
end

return M
