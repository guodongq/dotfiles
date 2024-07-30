local M = {
	"0x00-ketsu/maximizer.nvim",
	event = "VeryLazy",
	opts = {},
	dependencies = {
		-- pick a window
		"yorickpeterse/nvim-window",
	},
	keys = {
		{ "<leader>wd", "<cmd>wincmd c<cr>", desc = "Window: [D]elete Current Window", mode = "n" },
		{ "<leader>wD", "<cmd>wincmd o<cr>", desc = "Window: [D]elete Other Windows", mode = "n" },
		{ "<leader>wh", "<cmd>wincmd h<cr>", desc = "Window: Goto Left Window", mode = "n" },
		{ "<leader>wj", "<cmd>wincmd j<cr>", desc = "Window: Goto Down Window", mode = "n" },
		{ "<leader>wk", "<cmd>wincmd k<cr>", desc = "Window: Goto Up Window", mode = "n" },
		{ "<leader>wl", "<cmd>wincmd l<cr>", desc = "Window: Goto Right Window", mode = "n" },
		{ "<leader>ws", "<cmd>sp<cr>", desc = "Window: [S]plit Window", mode = "n" },
		{ "<leader>wv", "<cmd>vsp<cr>", desc = "Window: Split Window [V]ertically", mode = "n" },
		{
			"<leader>wm",
			"<cmd>lua require('maximizer').toggle()<cr>",
			desc = "Window: [M]aximize Current Window",
			mode = "n",
		},
		{ "<leader>wp", "<cmd>lua require('nvim-window').pick()<cr>", desc = "Window: [P]ick Window", mode = "n" },
	},
}

function M.config()
	-- windows-maximizer
	--require("maximizer").setup({})
	-- windows-pick
	require("nvim-window").setup({
		-- The characters available for hinting windows.
		chars = {
			"a",
			"b",
			"c",
			"d",
			"e",
			"f",
			"g",
			"h",
			"i",
			"j",
			"k",
			"l",
			"m",
			"n",
			"o",
			"p",
			"q",
			"r",
			"s",
			"t",
			"u",
			"v",
			"w",
			"x",
			"y",
			"z",
		},

		-- A group to use for overwriting the Normal highlight group in the floating
		-- window. This can be used to change the background color.
		normal_hl = "Normal",

		-- The highlight group to apply to the line that contains the hint characters.
		-- This is used to make them stand out more.
		hint_hl = "Bold",

		-- The border style to use for the floating window.
		border = "single",
	})
end

return M
