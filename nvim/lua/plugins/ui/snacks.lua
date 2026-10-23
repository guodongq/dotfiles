-- snacks.nvim: dashboard, indent guides, notifications, pickers, terminal and window zoom.
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
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
			},
		},
		indent = { enabled = true },
		notifier = { enabled = true },
		picker = { enabled = true },
	},
	keys = {
		{ "<leader>sf", function() Snacks.picker.files() end, desc = "[S]earch [F]iles" },
		{ "<leader>sg", function() Snacks.picker.grep() end, desc = "[S]earch by [G]rep" },
		{
			"<leader>sw",
			function() Snacks.picker.grep_word() end,
			mode = { "n", "x" },
			desc = "[S]earch current [W]ord",
		},
		{ "<leader>sr", function() Snacks.picker.recent() end, desc = "[S]earch [R]ecent files" },
		{ "<leader>sb", function() Snacks.picker.buffers() end, desc = "[S]earch [B]uffers" },
		{ "<leader>sh", function() Snacks.picker.help() end, desc = "[S]earch [H]elp" },
		{ "<leader>sk", function() Snacks.picker.keymaps() end, desc = "[S]earch [K]eymaps" },
		{ "<leader>sc", function() Snacks.picker.commands() end, desc = "[S]earch [C]ommands" },
		{ "<leader>bd", function() Snacks.bufdelete() end, desc = "[B]uffer [D]elete" },
		{ "<leader>bo", function() Snacks.bufdelete.other() end, desc = "[B]uffer delete [O]thers" },
		{ "<leader>wm", function() Snacks.zen.zoom() end, desc = "[M]aximize window" },
		{ "<c-/>", function() Snacks.terminal() end, mode = { "n", "t" }, desc = "Toggle terminal" },
		-- Most terminals send <c-_> for <c-/>.
		{ "<c-_>", function() Snacks.terminal() end, mode = { "n", "t" }, desc = "Toggle terminal" },
	},
}
