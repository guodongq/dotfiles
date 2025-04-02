return {
	{ -- Noice
		"folke/noice.nvim",
		enabled = false,
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
	{ -- Hop is a Neovim plugin to jump to any location in the visible area
		"smoka7/hop.nvim",
		version = "*",
		enabled = true,
		event = "VeryLazy",
		keys = {
			{ "<leader>j1", "<cmd>HopChar1<cr>", desc = "[J]ump [1] Character", mode = "n" },
			{ "<leader>j2", "<cmd>HopChar2<cr>", desc = "[J]ump [2] Characters", mode = "n" },
			{ "<leader>jl", "<cmd>HopLine<cr>", desc = "[J]ump [L]ine", mode = "n" },
			{ "<leader>jp", "<cmd>HopPattern<cr>", desc = "[J]ump By [P]attern", mode = "n" },
			{ "<leader>jw", "<cmd>HopWord<cr>", desc = "[J]ump To [W]ord", mode = "n" },
		},
		opts = {
			keys = "etovxqpdygfblzhckisuran",
		},
	},
	{ -- maximized is a Neovim plugin to maximize the current window
		"0x00-ketsu/maximizer.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{ "<leader>wm", "<cmd>lua require('maximizer').toggle()<cr>", desc = "[M]aximize Current [W]indow" },
		},
	},
	{ -- Pick a window
		"yorickpeterse/nvim-window",
		keys = {
			{ "<leader>wp", "<cmd>lua require('nvim-window').pick()<cr>", desc = "[P]ick [W]indow" },
		},
		opts = {
			-- The characters available for hinting windows.
			chars = {
				"a",
				"b",
				"c",
				"d",
				"e",
				"f",
				"g",
				"h",
				"i",
				"j",
				"k",
				"l",
				"m",
				"n",
				"o",
				"p",
				"q",
				"r",
				"s",
				"t",
				"u",
				"v",
				"w",
				"x",
				"y",
				"z",
			},

			-- A group to use for overwriting the Normal highlight group in the floating
			-- window. This can be used to change the background color.
			normal_hl = "Normal",

			-- The highlight group to apply to the line that contains the hint characters.
			-- This is used to make them stand out more.
			hint_hl = "Bold",

			-- The border style to use for the floating window.
			border = "single",

			-- How the hints should be rendered. The possible values are:
			--
			-- - "float" (default): renders the hints using floating windows
			-- - "status": renders the hints to a string and calls `redrawstatus`,
			--   allowing you to show the hints in a status or winbar line
			render = "float",
		},
	},
	{ -- Terminal
		"akinsho/toggleterm.nvim",
		version = "*",
		enabled = true,
		event = "VeryLazy",
		opts = {
			size = 20,
			open_mapping = [[<c-\>]],
			hide_numbers = true,
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			direction = "float", -- float, horizontal
			close_on_exit = true,
			shell = vim.o.shell,
			float_opts = {
				border = "curved",
			},
		},
		config = function(_, opt)
			require("toggleterm").setup(opt)

			function _G.set_terminal_keymaps()
				local opts = { noremap = true }
				vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
				vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
				vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<cmd>wincmd h<cr>]], opts)
				vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<cmd>wincmd j<cr>]], opts)
				vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<cmd>wincmd k<cr>]], opts)
				vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<cmd>wincmd l<cr>]], opts)
				vim.api.nvim_buf_set_keymap(0, "t", "<C-w>", [[<C-\><C-n><C-W>]], opts)
			end

			vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

			local Terminal = require("toggleterm.terminal").Terminal
			local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

			function _LAZYGIT_TOGGLE()
				lazygit:toggle()
			end
		end,
	},
	{ -- Highlight todo, notes, etc in comments
		"folke/todo-comments.nvim",
		event = "VimEnter",
		enabled = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
        -- stylua: ignore
        keys = {
            { '<leader>tt', '<cmd>TodoTelescope<cr>', desc = '[T]oggle [T]odo Comments' },
        },
	},
	{ -- Markdown highlight
		"tpope/vim-markdown",
		config = function()
			vim.g.markdown_syntax_conceal = 0
			vim.g.markdown_fenced_languages = {
				"python",
				"bash=sh",
				"html",
				"json",
				"java",
				"js=javascript",
				"sql",
				"yaml",
				"xml",
				"Dockerfile",
				"Rust",
				"lua",
				"go",
			}
		end,
	},
	{ -- Markdown preview
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
}

