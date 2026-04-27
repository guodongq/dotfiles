local M1 = {
	"folke/which-key.nvim",
	event = "VimEnter",
}

---@module 'which-key'
---@type wk.Opts
---@diagnostic disable-next-line: missing-fields
M1.opts = {
	delay = 0,
	icons = { mappings = vim.g.have_nerd_font },
	spec = {
		{ "<leader>s", group = "[S]earch", mode = { "n", "v" } },
		{ "<leader>t", group = "[T]oggle" },
		{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
		{ "gr", group = "LSP Actions", mode = { "n" } },

		{ "<leader>c", group = "[C]ode", mode = { "n", "x" } },
		{ "<leader>d", group = "[D]ocument" },
		{ "<leader>w", group = "[W]indows" },
		{ "<leader>b", group = "[B]uffer" },
		{ "<leader>j", group = "[J]ump" },
		{ "<leader>p", group = "[P]ersistence" },

		{ "s", group = "[S]urround" },
		{ "z", group = "Fold" },

		{ "<leader>H", "<cmd>nohlsearch<cr>", desc = "Clear [H]ighlights" },
		{ "<leader>Q", "<cmd>confirm qall<cr>", desc = "[Q]uit Neovim" },
		{ "<leader>S", "<cmd>w!<cr>", desc = "[S]ave file" },
	},
}

local M2 = {
	"0x00-ketsu/maximizer.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{ "<leader>wm", "<cmd>lua require('maximizer').toggle()<cr>", desc = "[M]aximize Current [W]indow" },
	},
}

local M3 = {
	"yorickpeterse/nvim-window",
	keys = {
		{ "<leader>wp", "<cmd>lua require('nvim-window').pick()<cr>", desc = "[P]ick [W]indow" },
	},
}

M3.opts = {
	chars = {
		"a", "b", "c", "d", "e", "f", "g", "h", "i", "j",
		"k", "l", "m", "n", "o", "p", "q", "r", "s", "t",
		"u", "v", "w", "x", "y", "z",
	},
	normal_hl = "Normal",
	hint_hl = "Bold",
	border = "single",
	render = "float",
}

local M4 = {
	"folke/noice.nvim",
	enabled = false,
	event = "VeryLazy",
	opts = {},
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
}

local M5 = {
	"goolord/alpha-nvim",
	event = "VimEnter",
	enabled = true,
}

M5.opts = function()
	local dashboard = require("alpha.themes.dashboard")
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
	dashboard.section.buttons.val = {
		dashboard.button("f", " " .. " Search Files", ":Telescope find_files<CR>"),
		dashboard.button("g", " " .. " Search by Grep", ":Telescope live_grep <CR>"),
		dashboard.button("p", " " .. " Search Projects", ":Telescope project<CR>"),
		dashboard.button("r", " " .. " Search Recent Files", ":Telescope oldfiles <CR>"),
		dashboard.button("a", " " .. " New File", [[<cmd> ene <BAR> startinsert <cr>]]),
		dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
		dashboard.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <cr>"),
		dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
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
end

M5.config = function(_, dashboard)
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
end

return { M1, M2, M3, M4, M5 }
