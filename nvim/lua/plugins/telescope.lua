local M = {
	"nvim-telescope/telescope.nvim",
	enabled = true,
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = function() return vim.fn.executable("make") == 1 end },
		{ "nvim-telescope/telescope-ui-select.nvim" },
	},
}

M.config = function()
	require("telescope").setup({
		extensions = {
			["ui-select"] = { require("telescope.themes").get_dropdown() },
		},
	})

	pcall(require("telescope").load_extension, "fzf")
	pcall(require("telescope").load_extension, "ui-select")

	local builtin = require("telescope.builtin")
	vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Find Files" })
	vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Grep" })
	vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "Buffers" })
	vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Help" })
	vim.keymap.set("n", "<leader>sc", builtin.commands, { desc = "Commands" })
end

return M
