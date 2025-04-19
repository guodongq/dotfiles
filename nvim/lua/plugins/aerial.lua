return {
  'stevearc/aerial.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = {
     "nvim-treesitter/nvim-treesitter",
     { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
  },
  keys = {
			{ "<leader>co", "<cmd>AerialToggle!<cr>", desc = "LSP: [C]ode [O]utline", silent = true },
		},
}