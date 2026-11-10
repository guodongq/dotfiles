-- What you see: colors, statusline, tabs, file explorer, pickers and key hints.
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

	-- Statusline
	{ "nvim-lualine/lualine.nvim", event = "VeryLazy", opts = {} },

	-- Tabs: open buffers along the top
	{
		"akinsho/bufferline.nvim",
		version = "*",
		event = "VeryLazy",
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				-- Snacks.bufdelete keeps the window layout, unlike :bdelete.
				close_command = function(buf) Snacks.bufdelete(buf) end,
				right_mouse_command = function(buf) Snacks.bufdelete(buf) end,
				offsets = {
					{ filetype = "NvimTree", text = "File Explorer", highlight = "Directory", separator = true },
				},
			},
		},
	},

	-- File explorer (replaces netrw)
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		init = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
		end,
		keys = {
			{ "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Toggle [E]xplorer" },
			{ "<leader>E", "<cmd>NvimTreeFindFile<cr>", desc = "Reveal current file in [E]xplorer" },
		},
		opts = {
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")
				api.map.on_attach.default(bufnr)

				local function map(lhs, rhs, desc)
					vim.keymap.set("n", lhs, rhs, { buffer = bufnr, nowait = true, desc = "nvim-tree: " .. desc })
				end
				map("u", api.tree.change_root_to_parent, "Up")
				map("?", api.tree.toggle_help, "Help")
				map("C", api.tree.change_root_to_node, "CD")
				map("l", api.node.open.edit, "Open")
			end,
			sort = { sorter = "case_sensitive" },
			renderer = { group_empty = true },
			diagnostics = { enable = true, show_on_dirs = true },
			filters = { dotfiles = true },
			update_focused_file = { enable = true, update_root = { enable = true } },
		},
	},

	-- Problems panel: diagnostics, symbols, quickfix and location lists
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		opts = {},
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / References (Trouble)",
			},
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
		},
	},

	-- Snacks: dashboard, pickers, terminal, notifications, indent guides
	-- and highlighting of the LSP references under the cursor (words)
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
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
			words = { enabled = true },
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
			{ "<c-_>", function() Snacks.terminal() end, mode = { "n", "t" }, desc = "Toggle terminal" }, -- <c-/> in most terminals
		},
	},

	-- Key hints: press <leader> and wait
	{
		"folke/which-key.nvim",
		event = "VimEnter",
		opts = {
			preset = "modern",
			delay = 0,
			spec = {
				{ "<leader>a", group = "[A]I", mode = { "n", "x" } },
				{ "<leader>b", group = "[B]uffer" },
				{ "<leader>c", group = "[C]ode" },
				{ "<leader>j", group = "[J]ump", mode = { "n", "x", "o" } },
				{ "<leader>p", group = "[P]roject Sessions" },
				{ "<leader>s", group = "[S]earch", mode = { "n", "x" } },
				{ "<leader>t", group = "[T]oggle" },
				{ "<leader>w", group = "[W]indows" },
				{ "<leader>x", group = "Diagnostics & Lists" },
				{ "[", group = "Prev" },
				{ "]", group = "Next" },
				{ "s", group = "[S]urround" },
				{ "z", group = "Fold" },
			},
		},
	},
}
