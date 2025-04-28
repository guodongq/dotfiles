return {
	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
        -- stylua: ignore
        keys = {
            { '<leader>tt', '<cmd>TodoTelescope<cr>', desc = '[T]oggle [T]odo Comments' },
        },
	},
	-- Collection of various small independent plugins/modules
	{
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()

			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			--  and try some other statusline plugin
			-- local statusline = require("mini.statusline")
			-- set use_icons to true if you have a Nerd Font
			-- statusline.setup({ use_icons = vim.g.have_nerd_font })

			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			-- ---@diagnostic disable-next-line: duplicate-set-field
			-- statusline.section_location = function()
			-- 	return "%2l:%-2v"
			-- end

			-- ... and there is more!
			--  Check out: https://github.com/echasnovski/mini.nvim
			require("mini.pairs").setup()
		end,
	},
	-- maximized is a Neovim plugin to maximize the current window
	{ 
		"0x00-ketsu/maximizer.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{ "<leader>wm", "<cmd>lua require('maximizer').toggle()<cr>", desc = "[M]aximize Current [W]indow" },
		},
	},
	 -- Hop is a Neovim plugin to jump to any location in the visible area
	{
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
	 -- Terminal
	{
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
	-- nvim-spectre is a Neovim plugin to replace files
	{
		"nvim-pack/nvim-spectre",
		build = false,
		cmd = "Spectre",
		keys = {
			{ "<leader>R", '<cmd>lua require("spectre").open()<cr>', desc = "Spectre: [R]e[n]ame" },
		},
		opts = { open_cmd = "noswapfile vnew" },
		-- stylua: ignore
	},
	-- Pick a window
	{
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
	 -- Noice.nvim is a Neovim plugin that provides a unified interface for displaying messages
	{
		"folke/noice.nvim",
		enabled = true,
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
	-- Dashboard
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		enabled = false,
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			-- Set header
			dashboard.section.header.val = {
				[[       /^v^\         |    |    |]],
				[[                    )_)  )_)  )_)     /^v^\]],
				[[          /^v^\    )___))___))___)\     https://github.com/guodongq/dotfiles]],
				[[                  )____)____)_____)\\]],
				[[                _____|____|____|____\\\__]],
				[[                \                   /]],
				[[    ^^^^^ ^^^^^^^^  ^^^^^ ^^^^^  ^^^^^ ^^^^ <><  ]],
				[[      ^^^^  ^^  ^^^    ^ ^^^    ^^^ <>< ^^^^     ]],
				[[       ><> ^^^     ^^    ><> ^^     ^^    ^      ]],
			}
			-- Set menu
			dashboard.section.buttons.val = {
				dashboard.button("f", " " .. " Search Files", ":Telescope find_files<CR>"),
				dashboard.button("g", " " .. " Search by Grep", ":Telescope live_grep <CR>"),
				dashboard.button("p", " " .. " Search Projects", ":Telescope project<CR>"),
				dashboard.button("r", " " .. " Search Recent Files", ":Telescope oldfiles <CR>"),
				dashboard.button("n", " " .. " New File", [[<cmd> ene <BAR> startinsert <cr>]]),
				dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
				dashboard.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <cr>"),
				dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
			}
			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = "AlphaButtons"
				button.opts.hl_shortcut = "AlphaShortcut"
			end
			dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.section.buttons.opts.hl = "AlphaButtons"
			dashboard.section.footer.opts.hl = "AlphaFooter"
			dashboard.opts.layout[1].val = 8
			return dashboard
		end,
		config = function(_, dashboard)
			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					once = true,
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			-- Set config to alpha
			require("alpha").setup(dashboard.opts)

			vim.api.nvim_create_autocmd("User", {
				once = true,
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					dashboard.section.footer.val = "⚡ Neovim loaded "
						.. stats.loaded
						.. "/"
						.. stats.count
						.. " plugins in "
						.. ms
						.. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "AlphaReady",
				callback = function()
					vim.cmd([[
                   set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
                ]])
				end,
			})
		end,
	},
}
