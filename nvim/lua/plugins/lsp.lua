-- LSP Configuration
-- Simple and performant language server setup

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

M.config = function()
	-- LSP keybindings
	vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- Navigation
				map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				map("gt", vim.lsp.buf.type_definition, "[G]oto [T]ype Definition")
				map("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
				map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")

				-- Symbols
				map("gO", vim.lsp.buf.document_symbol, "Document Symbols")
				map("gW", vim.lsp.buf.workspace_symbol, "Workspace Symbols")

				-- Actions
				map("gr", vim.lsp.buf.rename, "[R]ename")
				map("ga", vim.lsp.buf.code_action, "Code Actions", { "n", "x" })
				map("go", "<cmd>AerialToggle!<cr>", "Outline")

				-- Document highlight
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client:supports_method("textDocument/documentHighlight", event.buf) then
					local augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = true })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = augroup,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = augroup,
						callback = vim.lsp.buf.clear_references,
					})
					vim.api.nvim_create_autocmd("LspDetach", {
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

	-- LSP servers setup
	local servers = {
			-- Go
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
			-- Python
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
			-- TypeScript/JavaScript
			ts_ls = {
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
				},
			},
			-- C/C++
			clangd = {
				cmd = { "clangd", "--background-index", "--clang-tidy" },
				filetypes = { "c", "cpp", "objc", "objcpp" },
			},
			-- Java
			jdtls = {
				cmd = { "jdtls" },
				filetypes = { "java" },
			},
			-- Lua
			lua_ls = {
				on_init = function(client)
					if not client.workspace_folders then
						return
					end
					local path = client.workspace_folders[1].name
					if
						path ~= vim.fn.stdpath("config")
						and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
					then
						return
					end
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
			-- Markup
			marksman = {},
			jsonls = {},
			yamlls = {},
		}

	-- Setup servers
	for name, config in pairs(servers) do
			vim.lsp.config(name, config)
			vim.lsp.enable(name)
		end

	-- Install tools
	local tools = {
			-- Formatters
			"stylua",
			"prettier",
			"gofumpt",
			"goimports",
			"clang-format",
			"isort",
			"black",

			-- Linters
			"eslint",
			"ruff",
			"revive",
			"markdownlint",
		}

	vim.list_extend(tools, vim.tbl_keys(servers))
	require("mason-tool-installer").setup({ ensure_installed = tools })
end

return M
