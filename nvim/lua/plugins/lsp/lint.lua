local M = {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufNewFile" },
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

M.config = function(_, opts)
	local lint = require("lint")
	lint.linters_by_ft = opts.linters_by_ft

	vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
		group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
		callback = function()
			lint.try_lint()
		end,
	})
end

return M