local M = {
	"folke/todo-comments.nvim",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>st", "<cmd>TodoTelescope<cr>", desc = "[S]earch [T]odo" },
	},
	---@module 'todo-comments'
	---@type TodoOptions
	---@diagnostic disable-next-line: missing-fields
	opts = { signs = false },
}

return M