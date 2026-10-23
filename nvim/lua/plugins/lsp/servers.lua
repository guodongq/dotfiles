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
			pyright = {},
			vtsls = {},
			clangd = { cmd = { "clangd", "--background-index", "--clang-tidy" } },
			jdtls = {},
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

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local buf = event.buf
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if not client then
					return
				end

				local function map(keys, func, desc, method)
					if client:supports_method(method, buf) then
						vim.keymap.set("n", keys, func, { buffer = buf, desc = "LSP: " .. desc })
					end
				end

				-- Nvim already maps grn, gra, gri, grr, grt, grx and gO (see `:h lsp-defaults`).
				-- K is mapped here too: Nvim skips its default when an ftplugin sets 'keywordprg' (Go, Python).
				map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition", "textDocument/definition")
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration", "textDocument/declaration")
				map("K", vim.lsp.buf.hover, "Hover Documentation", "textDocument/hover")
				map("gK", vim.lsp.buf.signature_help, "Signature Help", "textDocument/signatureHelp")
				map("grw", vim.lsp.buf.workspace_symbol, "Workspace Symbols", "workspace/symbol")
				map("<leader>th", function()
					local filter = { bufnr = buf }
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(filter), filter)
				end, "[T]oggle Inlay [H]ints", "textDocument/inlayHint")

				-- Highlight references of the word under the cursor.
				if client:supports_method("textDocument/documentHighlight", buf) then
					-- Several clients may attach to one buffer; keep a single set of autocmds.
					vim.api.nvim_clear_autocmds({ group = highlight_group, buffer = buf })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						group = highlight_group,
						buffer = buf,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						group = highlight_group,
						buffer = buf,
						callback = vim.lsp.buf.clear_references,
					})
					vim.api.nvim_create_autocmd("LspDetach", {
						group = highlight_group,
						buffer = buf,
						callback = function(detach)
							for _, other in ipairs(vim.lsp.get_clients({ bufnr = buf })) do
								local method = "textDocument/documentHighlight"
								if other.id ~= detach.data.client_id and other:supports_method(method, buf) then
									return
								end
							end
							vim.lsp.util.buf_clear_references(buf)
							vim.api.nvim_clear_autocmds({ group = highlight_group, buffer = buf })
						end,
					})
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
