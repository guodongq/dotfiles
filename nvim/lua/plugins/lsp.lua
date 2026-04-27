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
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
		callback = function(event)
			local map = function(keys, func, desc, mode)
				mode = mode or "n"
				vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
			end

			map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
			map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
			map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
			map("gro", "<cmd>AerialToggle!<cr>", "[C]ode [O]utline")

			local client = vim.lsp.get_client_by_id(event.data.client_id)
			if client and client:supports_method("textDocument/documentHighlight", event.buf) then
				local highlight_augroup =
					vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.document_highlight,
				})
				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.clear_references,
				})
				vim.api.nvim_create_autocmd("LspDetach", {
					group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
					callback = function(event2)
						vim.lsp.buf.clear_references()
						vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
					end,
				})
			end

			if client and client:supports_method("textDocument/inlayHint", event.buf) then
				map("<leader>th", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
				end, "[T]oggle Inlay [H]ints")
			end
		end,
	})

	---@type table<string, vim.lsp.Config>
	local servers = {
		gopls = {
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			root_dir = function(fname)
				local util = require("lspconfig.util")
				local async = require("lspconfig.async")

				local mod_cache = async.run_command({ "go", "env", "GOMODCACHE" })
						and vim.trim((async.run_command({ "go", "env", "GOMODCACHE" }))[1])
					or vim.trim(vim.fn.system("go env GOMODCACHE"))

				if mod_cache and fname:sub(1, #mod_cache) == mod_cache then
					local existing_clients = vim.lsp.get_lsp_clients({ name = "gopls" })
					if #existing_clients > 0 then
						return existing_clients[#existing_clients].config.root_dir
					end
				end

				return util.root_pattern("go.work", "go.mod", ".git")(fname)
			end,
			single_file_support = true,
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
					analyses = {
						unusedparams = true,
					},
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
			before_init = function(_, config)
				local util = require("lspconfig/util")
				local path = util.path

				local function get_python_path(workspace)
					if vim.env.VIRTUAL_ENV then
						return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
					end
					for _, pattern in ipairs({ "*", ".*" }) do
						local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
						if match ~= "" then
							return path.join(path.dirname(match), "bin", "python")
						end
					end
					return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
				end

				config.settings.python.pythonPath = get_python_path(config.root_dir)
			end,
		},
		marksman = {},
		stylua = {},
		lua_ls = {
			on_init = function(client)
				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if
						path ~= vim.fn.stdpath("config")
						and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
					then
						return
					end
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
			settings = {
				Lua = {},
			},
		},
	}

	local ensure_installed = vim.tbl_keys(servers or {})
	vim.list_extend(ensure_installed, {
		"stylua",
		"markdownlint",
		"ruff",
		"revive",
		"isort",
		"black",
		"gofumpt",
		"goimports",
	})

	require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

	for name, server in pairs(servers) do
		vim.lsp.config(name, server)
		vim.lsp.enable(name)
	end
end

return M
