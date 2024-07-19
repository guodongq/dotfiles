------------------------------------
-- Mason, LSP，Linter，DAP Configuration --
------------------------------------
local M = {}

M.mason = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

M.lsp = {
	-- "asm_lsp",
	-- "bashls",
	-- "clangd",
	-- "cmake",
	"gopls",
	-- "jsonls",
	"marksman",
	"lua_ls",
	"pyright",
	-- "terraformls",
	-- "yamlls",
	-- "html",
}

M.linter = {
	-- "cmakelang",
	-- "gitlint",
	"goimports",
	--"golangci-lint",
	-- "jsonlint",
	"markdownlint",
	-- "protolint",
	"pylint",
	-- "yamllint",
}

M.dap = {
	 "delve",
	-- "cpptools",
	-- "bash-debug-adapter",
}

return M
