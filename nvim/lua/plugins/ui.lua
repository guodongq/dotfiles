-- Theme, file browsing, pickers and key hints.
return {
	-- Colorscheme
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		opts = { styles = { comments = { italic = false } } },
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd.colorscheme("tokyonight")
		end,
	},

	-- One picker for files, search and diagnostics.
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			explorer = { enabled = true },
			picker = {
				enabled = true,
				sources = {
					explorer = {
						win = {
							list = {
								keys = {
									["o"] = "confirm",
									["u"] = "explorer_up",
									["C"] = "explorer_focus",
									["R"] = "explorer_update",
								},
							},
						},
					},
				},
			},
		},
		keys = {
			{ "<leader>e", function() Snacks.explorer() end, desc = "File explorer" },
			{ "<leader>sf", function() Snacks.picker.files() end, desc = "Find files" },
			{ "<leader>sg", function() Snacks.picker.grep() end, desc = "Search text" },
			{
				"<leader>sw",
				function() Snacks.picker.grep_word() end,
				mode = { "n", "x" },
				desc = "Search selection or word",
			},
			{ "<leader>sb", function() Snacks.picker.buffers() end, desc = "Find buffers" },
			{ "<leader>sh", function() Snacks.picker.help() end, desc = "Search help" },
			{ "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Search keymaps" },
			{ "<leader>bd", function() Snacks.bufdelete() end, desc = "Close buffer" },
			{
				"<leader>xx",
				function() Snacks.picker.diagnostics({ filter = { cwd = false } }) end,
				desc = "Diagnostics",
			},
			{ "<c-/>", function() Snacks.terminal() end, mode = { "n", "t" }, desc = "Toggle terminal" },
			{ "<c-_>", function() Snacks.terminal() end, mode = { "n", "t" }, desc = "Toggle terminal" }, -- <c-/> in most terminals
		},
	},

	-- Key hints: press <leader> and wait
	{
		"folke/which-key.nvim",
		event = "VimEnter",
		opts = {
			delay = 300,
			spec = {
				{ "<leader>a", group = "AI", mode = { "n", "x" } },
				{ "<leader>b", group = "Buffers" },
				{ "<leader>s", group = "Search", mode = { "n", "x" } },
				{ "<leader>x", group = "Diagnostics" },
			},
		},
	},
}
