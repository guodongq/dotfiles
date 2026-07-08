local M = {
	"nvim-pack/nvim-spectre",
	build = false,
	cmd = "Spectre",
	keys = {
		{ "<leader>R", function() require("spectre").open() end, desc = "Spectre: [R]eplace in Files" },
	},
	opts = { open_cmd = "noswapfile vnew" },
}

return M
