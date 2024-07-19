local M = {
	"nvim-tree/nvim-tree.lua",
	event = "VeryLazy",
	keys = {
		{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle Explorer", mode = "n" },
	},
}

local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree:" .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)
	-- custom mappings
	vim.keymap.set("n", "u", api.tree.change_root_to_parent, opts("Up"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
	vim.keymap.set("n", "C", api.tree.change_root_to_node, opts("CD"))
	vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
end

function M.config()
	-- disable netrw at the very start of your init.lua
	-- vim.g.loaded_netrw = 1
	-- vim.g.loaded_netrwPlugin = 1

	require("nvim-tree").setup({
		on_attach = on_attach,
		update_focused_file = {
			enable = true,
			update_cwd = true,
		},
		sort = {
			sorter = "case_sensitive",
		},
		view = {
			-- width = 30,
			adaptive_size = true,
			side = "left",
		},
		renderer = {
			group_empty = true,
		},
		diagnostics = {
			enable = true,
			show_on_dirs = false,
		},
		filters = {
			dotfiles = true,
		},
	})
end

return M
