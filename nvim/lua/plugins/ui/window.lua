-- Window zoom now lives in ui/snacks.lua (Snacks.zen.zoom); this plugin only
-- handles picking a window by label, which snacks.nvim doesn't provide.
local M = {
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

return M
