local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")
	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end
	-- default mappings
	api.config.mappings.default_on_attach(bufnr)
	-- custom mappings
	vim.keymap.set("n", "u", api.tree.change_root_to_parent, opts("Up"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
	vim.keymap.set("n", "C", api.tree.change_root_to_node, opts("CD"))
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
	update_focused_file = {
		enable = true,
		update_root = true,
	},
	sort_by = "case_sensitive",
	view = {
		width = 35,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
	on_attach = my_on_attach,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("NVIM_TREE", { clear = true }),
	pattern = "NvimTree",
	callback = function()
		vim.api.nvim_win_set_option(0, "wrap", false)
	end,
})
