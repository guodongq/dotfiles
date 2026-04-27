local M = {
	"lewis6991/gitsigns.nvim",
}

M.opts = {
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
}

return M
