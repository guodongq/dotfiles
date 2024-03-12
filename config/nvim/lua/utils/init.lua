local M = {}

-- Lsp servers
M.lsp_servers = {
	"asm_lsp",
	"bashls",
	"clangd",
	"cmake",
	"gopls",
	"jsonls",
	"marksman",
	"lua_ls",
	"pyright",
	"terraformls",
	"yamlls",
	"html",
}

-- null-ls servers
M.null_ls_servers = {
	"cmakelang",
	"gitlint",
	"goimports",
	"golangci-lint",
	"jsonlint",
	"markdownlint",
	"protolint",
	"pylint",
	"yamllint",
}

-- Dap servers
M.dap_servers = {
	"delve",
	"cpptools",
	"bash-debug-adapter",
}

return M
