return {
	{
		"folke/which-key.nvim",
		event = "VimEnter",
		opts = {
			plugins = { spelling = true },
			defaults = {
				mode = { "n", "v" },
				["<leader>b"] = { name = "+buffer" },
				["<leader>c"] = { name = "+comment" },
				["<leader>f"] = { name = "+file" },
				["<leader>h"] = { name = "+help" },
				["<leader>j"] = { name = "+jump" },
				["<leader>l"] = { name = "+lsp" },
				["<leader>q"] = { name = "+quit" },
				["<leader>s"] = { name = "+search" },
				["<leader>w"] = { name = "+window" },
			},
		},
		config = function(_, opts)
			vim.o.timeout = true
			vim.o.timeoutlen = 300

			local wk = require("which-key")
			wk.setup(opts)
			wk.register(opts.defaults)
		end,
	},
}
