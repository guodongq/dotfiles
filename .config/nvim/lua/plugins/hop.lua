local M = {
	"smoka7/hop.nvim",
	version = "*",
	event = "VeryLazy",
	keys = {
		{ "<leader>j1", "<cmd>HopChar1<cr>", desc = "[J]umpTo [1] Character", mode = "n" },
		{ "<leader>j2", "<cmd>HopChar2<cr>", desc = "[J]umpTo Suite Of [2] Characters", mode = "n" },
		{ "<leader>jl", "<cmd>HopLine<cr>", desc = "[J]umpTo [L]ine", mode = "n" },
		{ "<leader>jp", "<cmd>HopPattern<cr>", desc = "[J]umpTo By [P]attern", mode = "n" },
		{ "<leader>jw", "<cmd>HopWord<cr>", desc = "[J]umpTo [W]ord", mode = "n" },
	},
	opts = {
		keys = "etovxqpdygfblzhckisuran",
	},
}

return M
