local M = {}

-- Lsp servers
M.lservers = {
	"asm_lsp",
	"bashls",
	"clangd",
	"cmake",
	"gopls",
	"jsonls",
	"marksman",
	"lua_ls",
	"pyright",
	"taplo",
	"terraformls",
	"yamlls",
	"html",
}

-- null-ls servers
M.nservers = {
	"clang-format",
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
M.dservers = {
	"delve",
	"cpptools",
	"bash-debug-adapter",
}

return M
