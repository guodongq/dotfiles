return { -- maximized is a Neovim plugin to maximize the current window
	"0x00-ketsu/maximizer.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{ "<leader>wm", "<cmd>lua require('maximizer').toggle()<cr>", desc = "Window: [M]aximize Current Window" },
	},
}

