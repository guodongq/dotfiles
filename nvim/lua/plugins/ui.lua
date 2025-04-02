return {
	{ -- Dashboard
		"goolord/alpha-nvim",
		event = "VimEnter",
		enabled = true,
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
	{ -- Bufferline
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		version = "*",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
			-- delete other buffers
			"numToStr/Buffers.nvim",
			-- list buffers
			"nvim-telescope/telescope.nvim",
		},
		keys = {
			{
				"<leader>ba",
				"<cmd>lua require('Buffers').clear()<cr>",
				desc = "Delete [A]ll Buffers",
				mode = "n",
			},
			{
				"<leader>bd",
				"<cmd>lua require('Buffers').delete()<cr>",
				desc = "[D]elete Current Buffer",
				mode = "n",
			},
			{
				"<leader>bD",
				"<cmd>BufferLineCloseOthers<cr>",
				desc = "[D]elete Other Buffers",
				mode = "n",
			},
			{
				"<leader>bn",
				"<cmd>BufferLineCycleNext<cr>",
				desc = "[N]ext Buffer",
				mode = "n",
			},
			{
				"<leader>bp",
				"<cmd>BufferLineCyclePrev<cr>",
				desc = "[P]revious Buffer",
				mode = "n",
			},
			{
				"<leader>bl",
				"<cmd>Telescope buffers path_display={'truncate'}<cr>",
				desc = "[L]ist Buffers",
				mode = "n",
			},
		},
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				separator_style = "thin",
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "center",
						highlight = "Directory",
						separator = true,
					},
				},
			},
			highlights = {
				fill = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},
				background = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},
				buffer_visible = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},
				close_button = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},
				close_button_visible = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},
				tab_selected = {
					fg = { attribute = "fg", highlight = "Normal" },
					bg = { attribute = "bg", highlight = "Normal" },
				},
				tab = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},
				tab_close = {
					-- fg = {attribute='fg',highlight='LspDiagnosticsDefaultError'},
					fg = { attribute = "fg", highlight = "TabLineSel" },
					bg = { attribute = "bg", highlight = "Normal" },
				},
				duplicate_selected = {
					fg = { attribute = "fg", highlight = "TabLineSel" },
					bg = { attribute = "bg", highlight = "TabLineSel" },
					italic = true,
				},
				duplicate_visible = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
					italic = true,
				},
				duplicate = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
					italic = true,
				},
				modified = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},
				modified_selected = {
					fg = { attribute = "fg", highlight = "Normal" },
					bg = { attribute = "bg", highlight = "Normal" },
				},
				modified_visible = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},
				separator = {
					fg = { attribute = "bg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},
				separator_selected = {
					fg = { attribute = "bg", highlight = "Normal" },
					bg = { attribute = "bg", highlight = "Normal" },
				},
				indicator_selected = {
					fg = { attribute = "fg", highlight = "LspDiagnosticsDefaultHint" },
					bg = { attribute = "bg", highlight = "Normal" },
				},
			},
		},
		config = function(_, opts)
			require("bufferline").setup(opts)
			-- Fix bufferline when restoring a session
			vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
				callback = function()
					vim.schedule(function()
						---@diagnostic disable-next-line: undefined-global
						pcall(nvim_bufferline)
					end)
				end,
			})
		end,
	},
	{ -- Lualine
		"nvim-lualine/lualine.nvim",
		enabled = true,
		event = "VeryLazy",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		init = function()
			vim.g.lualine_laststatus = vim.o.laststatus
			if vim.fn.argc(-1) > 0 then
				-- set an empty statusline till lualine loads
				vim.o.statusline = " "
			else
				-- hide the statusline on the starter page
				vim.o.laststatus = 0
			end
		end,
		opts = {},
	},
}

