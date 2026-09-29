return {
	"nvim-pack/nvim-spectre",
	build = false,
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = "Spectre",
	keys = {
		{
			"<leader>R",
			function()
				require("spectre").open()
			end,
			desc = "Spectre: [R]eplace in Files",
		},
	},
	opts = { open_cmd = "noswapfile vnew" },
}
