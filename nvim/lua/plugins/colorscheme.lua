return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.opt.termguicolors = true
			vim.opt.background = "dark"

			vim.cmd.colorscheme("tokyonight")
			--vim.api.nvim_command("colorscheme tokyonight")
		end,
		enabled = true,
	},
  {
    "numToStr/Sakura.nvim",
    config = function()
      require("Sakura").load()
    end,
    enabled = false,
  }
}
