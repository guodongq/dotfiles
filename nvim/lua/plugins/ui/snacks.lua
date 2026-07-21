-- folke/snacks.nvim: consolidates dashboard (was alpha-nvim), indent guides
-- (was indent-blankline.nvim) and window zoom (was maximizer.nvim), and adds
-- a nicer vim.notify.
local M = {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
}

---@type snacks.Config
M.opts = {
	dashboard = {
		enabled = true,
		preset = {
			header = [[
       /^v^\         |    |    |
                    )_)  )_)  )_)     /^v^\
          /^v^\    )___))___))___)\     https://github.com/guodongq/dotfiles
                  )____)____)_____)\\
                _____|____|____|____\\\__
                \                   /
    ^^^^^ ^^^^^^^^  ^^^^^ ^^^^^  ^^^^^ ^^^^ <><  
      ^^^^  ^^  ^^^    ^ ^^^    ^^^ <>< ^^^^     
       ><> ^^^     ^^    ><> ^^     ^^    ^      
]],
			keys = {
				{ icon = " ", key = "f", desc = "Search Files", action = ":Telescope find_files" },
				{ icon = " ", key = "g", desc = "Search by Grep", action = ":Telescope live_grep" },
				{ icon = " ", key = "r", desc = "Search Recent Files", action = ":Telescope oldfiles" },
				{ icon = " ", key = "a", desc = "New File", action = ":ene | startinsert" },
				{ icon = " ", key = "c", desc = "Config", action = ":edit $MYVIMRC" },
				{ icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
				{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
			},
		},
	},
	indent = { enabled = true },
	notifier = { enabled = true },
	zen = { enabled = true },
}

M.keys = {
	{ "<leader>wm", function() Snacks.zen.zoom() end, desc = "Maximize Window" },
}

return M
