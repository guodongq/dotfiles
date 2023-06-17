		use({
			"folke/trouble.nvim",
			event = "BufReadPost",
			requires = "nvim-tree/nvim-web-devicons",
			config = function()
				require("trouble").setup()
			end,
		})

		use({
			"folke/todo-comments.nvim",
			after = "nvim-treesitter",
			event = "BufReadPost",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("todo-comments").setup()
			end,
		})