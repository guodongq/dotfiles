-- folke/snacks.nvim provides dashboard, indent guides, window zoom,
-- notifications, terminals, and file finding; nvim-tree handles the explorer.
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		picker = {
			enabled = true,
		},
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
					{ icon = " ", key = "f", desc = "Search Files", action = ":lua Snacks.picker.files()" },
					{ icon = " ", key = "g", desc = "Search by Grep", action = ":lua Snacks.picker.grep()" },
					{ icon = " ", key = "r", desc = "Search Recent Files", action = ":lua Snacks.picker.recent()" },
					{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
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
		terminal = { enabled = true },
	},
	keys = {
		{
			"<leader>sf",
			function()
				Snacks.picker.files()
			end,
			desc = "[S]earch [F]iles",
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep()
			end,
			desc = "[S]earch by [G]rep",
		},
		{
			"<leader>sb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "[S]earch [B]uffers",
		},
		{
			"<leader>sh",
			function()
				Snacks.picker.help()
			end,
			desc = "[S]earch [H]elp",
		},
		{
			"<leader>sc",
			function()
				Snacks.picker.commands()
			end,
			desc = "[S]earch [C]ommands",
		},
		{
			"<leader>wm",
			function()
				Snacks.zen.zoom()
			end,
			desc = "Maximize Window",
		},
		{
			"<c-/>",
			function()
				Snacks.terminal()
			end,
			desc = "Toggle Terminal",
			mode = { "n", "t" },
		},
		{
			"<c-_>",
			function()
				Snacks.terminal()
			end,
			desc = "Toggle Terminal",
			mode = { "n", "t" },
		},
	},
}
