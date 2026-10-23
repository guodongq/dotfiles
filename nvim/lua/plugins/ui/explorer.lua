-- File explorer; replaces netrw.
return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	keys = {
		{ "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Toggle [E]xplorer" },
		{ "<leader>E", "<cmd>NvimTreeFindFile<cr>", desc = "Reveal current file in [E]xplorer" },
	},
	init = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
	end,
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
}
