local M = {
	"folke/which-key.nvim",
	event = "VimEnter",
}

---@module 'which-key'
---@type wk.Opts
---@diagnostic disable-next-line: missing-fields
M.opts = {
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

return M
