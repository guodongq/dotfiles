local M1 = {
	"NMAC427/guess-indent.nvim",
	opts = {},
}

local M2 = {
	"nvim-mini/mini.nvim",
}

M2.config = function()
	require("mini.ai").setup({ n_lines = 500 })
	require("mini.surround").setup()

	local statusline = require("mini.statusline")
	statusline.setup({ use_icons = vim.g.have_nerd_font })
	---@diagnostic disable-next-line: duplicate-set-field
	statusline.section_location = function()
		return "%2l:%-2v"
	end

	require("mini.pairs").setup()
end

local M3 = {
	"folke/todo-comments.nvim",
	event = "VimEnter",
	dependencies = { "nvim-lua/plenary.nvim" },
	---@module 'todo-comments'
	---@type TodoOptions
	---@diagnostic disable-next-line: missing-fields
	opts = { signs = false },
}

local M4 = {
	"smoka7/hop.nvim",
	version = "*",
	enabled = true,
	event = "VeryLazy",
	keys = {
		{ "<leader>j1", "<cmd>HopChar1<cr>", desc = "[J]ump [1] Character", mode = "n" },
		{ "<leader>j2", "<cmd>HopChar2<cr>", desc = "[J]ump [2] Characters", mode = "n" },
		{ "<leader>jl", "<cmd>HopLine<cr>", desc = "[J]ump [L]ine", mode = "n" },
		{ "<leader>jp", "<cmd>HopPattern<cr>", desc = "[J]ump By [P]attern", mode = "n" },
		{ "<leader>jw", "<cmd>HopWord<cr>", desc = "[J]ump To [W]ord", mode = "n" },
	},
}

M4.opts = {
	keys = "etovxqpdygfblzhckisuran",
}

local M5 = {
	"nvim-pack/nvim-spectre",
	build = false,
	cmd = "Spectre",
	keys = {
		{ "<leader>R", '<cmd>lua require("spectre").open()<cr>', desc = "Spectre: [R]e[n]ame" },
	},
	opts = { open_cmd = "noswapfile vnew" },
}

return { M1, M2, M3, M4, M5 }
