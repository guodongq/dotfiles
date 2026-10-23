return {
	"folke/tokyonight.nvim",
	priority = 1000,
	opts = { styles = { comments = { italic = false } } },
	config = function(_, opts)
		require("tokyonight").setup(opts)
		vim.cmd.colorscheme("tokyonight")
	end,
}
