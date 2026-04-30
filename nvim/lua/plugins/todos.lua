local M = {
	"folke/todo-comments.nvim",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },
	---@module 'todo-comments'
	---@type TodoOptions
	---@diagnostic disable-next-line: missing-fields
	opts = { signs = false },
}

return M