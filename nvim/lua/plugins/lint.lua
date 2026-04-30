local M = {
	"mfussenegger/nvim-lint",
	event = "BufWritePost",
}

M.opts = {
	linters_by_ft = {
		javascript = { "eslint" },
		typescript = { "eslint" },
		javascriptreact = { "eslint" },
		typescriptreact = { "eslint" },
		python = { "ruff" },
		go = { "revive" },
		lua = { "luacheck" },
	},
}

return M