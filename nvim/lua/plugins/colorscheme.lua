return {
	{ -- Tokyonight
		-- You can easily change to a different colorscheme.
		-- Change the name of the colorscheme plugin below, and then
		-- change the command in the config to whatever the name of that colorscheme is.
		--
		-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
		"folke/tokyonight.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		enabled = true,
		init = function()
			-- Load the colorscheme here.
			-- Like many other themes, this one has different styles, and you could load
			-- any other, such as 'tokyonight-storm', 'tokyonight-moon', 'tokyonight-night', or 'tokyonight-day'
			vim.cmd.colorscheme("tokyonight")

			-- You can configure highlights by doing something like:
			vim.cmd.hi("Comment gui=none")
		end,
	},
	{ -- Gruvbox
		"ellisonleao/gruvbox.nvim",
		enabled = false,
		--lazy = false,
		-- config = false,
		priority = 1000,
		init = function()
			vim.opt.background = "dark"
			vim.cmd.colorscheme("gruvbox")

			-- You can configure highlights by doing something like:
			vim.cmd.hi("Comment gui=none")
		end,
	},
	{ -- Sakura
		"numToStr/Sakura.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("Sakura").load()
		end,
	},
	{ -- Catppuccin
		"catppuccin/nvim",
		name = "catppuccin",
		enabled = false,
		lazy = false,
		priority = 1000,
		init = function()
			vim.opt.background = "dark"
		end,
		config = function()
			vim.cmd.colorscheme("catppuccin")
		end,
		opts = {
			integrations = {
				aerial = true,
				alpha = true,
				cmp = true,
				dashboard = true,
				flash = true,
				gitsigns = true,
				headlines = true,
				illuminate = true,
				indent_blankline = { enabled = true },
				leap = true,
				lsp_trouble = true,
				mason = true,
				markdown = true,
				mini = true,
				native_lsp = {
					enabled = true,
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
				},
				navic = { enabled = true, custom_bg = "lualine" },
				neotest = true,
				neotree = true,
				noice = true,
				notify = true,
				semantic_tokens = true,
				telescope = true,
				treesitter = true,
				treesitter_context = true,
				which_key = true,
			},
		},
	},
	{ -- Spaceduck
		"spaceduck-theme/nvim",
		name = "spaceduck",
		enabled = false,
		lazy = false,
		priority = 1000,
		init = function()
			vim.opt.background = "dark"
		end,
		config = function()
			vim.cmd.colorscheme("spaceduck")
		end,
	},
}

