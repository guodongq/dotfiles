local M = {
	"0x00-ketsu/maximizer.nvim",
	keys = {
		{ "<leader>wm", function() require("maximizer").toggle() end, desc = "Maximize Window" },
	},
}

local M2 = {
	"yorickpeterse/nvim-window",
	keys = {
		{ "<leader>wp", function() require("nvim-window").pick() end, desc = "Pick Window" },
	},
	opts = {
		chars = { "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" },
		normal_hl = "Normal",
		hint_hl = "Bold",
		border = "single",
		render = "float",
	},
}

return { M, M2 }
