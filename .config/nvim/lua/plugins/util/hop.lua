local M = {
	"smoka7/hop.nvim",
	version = "*",
	event = "VeryLazy",
	keys = {
		{ "<leader>j1", "<cmd>HopChar1<cr>", desc = "Jump To A Character", mode = "n" },
		{ "<leader>j2", "<cmd>HopChar2<cr>", desc = "Jump To Suite Of Two Characters", mode = "n" },
		{ "<leader>jl", "<cmd>HopLine<cr>", desc = "Jump To A Line", mode = "n" },
		{ "<leader>jp", "<cmd>HopPattern<cr>", desc = "Jump To A Pattern", mode = "n" },
		{ "<leader>jw", "<cmd>HopWord<cr>", desc = "Jump To A Word", mode = "n" },
	},
}

function M.config()
	require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
end

return M
