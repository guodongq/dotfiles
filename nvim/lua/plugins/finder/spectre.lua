local M = {
	"nvim-pack/nvim-spectre",
	build = false,
	cmd = "Spectre",
	keys = {
		{ "<leader>R", '<cmd>lua require("spectre").open()<cr>', desc = "Spectre: [R]eplace in Files" },
	},
	opts = { open_cmd = "noswapfile vnew" },
}

return M
