-- Mason installs `servers` via mason-lspconfig and extra `tools` via mason-tool-installer.

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
	},
	opts = {
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
			vtsls = {
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
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
					local workspace = client.workspace_folders and client.workspace_folders[1]
					if not workspace then
						return
					end
					local path = workspace.name
					if
						path ~= vim.fn.stdpath("config")
						and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
					then
						return
					end
					client.config.settings = client.config.settings or {}
					client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua or {}, {
						runtime = {
							version = "LuaJIT",
							path = { "lua/?.lua", "lua/?/init.lua" },
						},
						workspace = {
							checkThirdParty = false,
							library = vim.list_extend(vim.api.nvim_get_runtime_file("", true), {
								"${3rd}/luv/library",
								"${3rd}/busted/library",
							}),
						},
					})
				end,
			},
			marksman = {},
			jsonls = {},
			yamlls = {},
		},
		-- Additional formatters, linters and AI tools.
		tools = {
			"stylua",
			"prettier",
			"gofumpt",
			"goimports",
			"clang-format",
			"eslint_d",
			"ruff",
			"revive",
			"markdownlint",
			"copilot-language-server", -- GitHub Copilot LSP, used by sidekick.nvim
		},
	},
	config = function(_, opts)
		local highlight_group = vim.api.nvim_create_augroup("lsp-highlight", { clear = true })
		local detach_group = vim.api.nvim_create_augroup("lsp-detach", { clear = true })

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if not client then
					vim.notify("LspAttach: client not found", vim.log.levels.ERROR)
					return
				end

				local function map(keys, func, desc, method, mode)
					if client:supports_method(method, event.buf) then
						vim.keymap.set(mode or "n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
				end

				-- Nvim >= 0.11 already maps grn/gra/gri/grr/grt/grx/gO globally to the
				-- matching vim.lsp.buf.*/codelens functions (see `:h lsp-defaults`), so
				-- only keymaps without a built-in default are added here.
				map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition", "textDocument/definition")
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration", "textDocument/declaration")
				map("K", vim.lsp.buf.hover, "Hover Documentation", "textDocument/hover")
				map("gK", vim.lsp.buf.signature_help, "Signature Help", "textDocument/signatureHelp")
				map("grd", vim.lsp.buf.document_symbol, "Document Symbols", "textDocument/documentSymbol")
				map("grw", vim.lsp.buf.workspace_symbol, "Workspace Symbols", "workspace/symbol")
				map(
					"gro",
					"<cmd>Trouble symbols toggle focus=false<cr>",
					"Code [O]utline",
					"textDocument/documentSymbol"
				)

				if
					client:supports_method("textDocument/documentHighlight", event.buf)
					and #vim.api.nvim_get_autocmds({
							group = highlight_group,
							event = "CursorHold",
							buffer = event.buf,
						})
						== 0
				then
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_group,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_group,
						callback = vim.lsp.buf.clear_references,
					})
					vim.api.nvim_create_autocmd("LspDetach", {
						buffer = event.buf,
						group = detach_group,
						callback = function(detach)
							for _, other in ipairs(vim.lsp.get_clients({ bufnr = detach.buf })) do
								if
									other.id ~= detach.data.client_id
									and other:supports_method("textDocument/documentHighlight", detach.buf)
								then
									return
								end
							end
							vim.api.nvim_buf_call(detach.buf, vim.lsp.buf.clear_references)
							vim.api.nvim_clear_autocmds({ group = highlight_group, buffer = detach.buf })
							vim.api.nvim_clear_autocmds({ group = detach_group, buffer = detach.buf })
						end,
					})
				end

				if client:supports_method("textDocument/inlayHint", event.buf) then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(
							not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }),
							{ bufnr = event.buf }
						)
					end, "Toggle Hints", "textDocument/inlayHint")
				end
			end,
		})

		-- Configure language servers before enabling them.
		for name, config in pairs(opts.servers) do
			vim.lsp.config(name, config)
		end

		local servers = vim.tbl_keys(opts.servers)
		require("mason-lspconfig").setup({
			ensure_installed = servers,
			automatic_enable = false,
		})
		require("mason-tool-installer").setup({ ensure_installed = opts.tools })

		vim.lsp.enable(servers)

		-- Copilot is installed as a Mason tool and provides Sidekick's next edits.
		vim.lsp.enable("copilot")
	end,
}
