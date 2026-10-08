return {
	"folke/which-key.nvim",
	event = "VimEnter",
	---@module 'which-key'
	---@type wk.Opts
	---@diagnostic disable-next-line: missing-fields
	opts = {
		preset = "modern",
		delay = 0,
		icons = { mappings = vim.g.have_nerd_font },
		spec = {
			{ "<leader>s", group = "[S]earch", mode = { "n", "v" } },
			{ "<leader>t", group = "[T]oggle" },
			{ "<leader>x", group = "Trouble/Diagnostics" },
			{ "<leader>p", group = "[P]ersistence/Session" },
			{ "<leader>c", group = "[C]ode", mode = { "n", "x" } },
			{ "<leader>w", group = "[W]indows" },
			{ "<leader>j", group = "[J]ump" },
			{ "<leader>a", group = "[A]I" },
			{ "]", group = "Next" },
			{ "[", group = "Prev" },
			{ "s", group = "[S]urround" },
			{ "z", group = "Fold" },
		},
	},
}
