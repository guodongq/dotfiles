return {
	"folke/which-key.nvim",
	event = "VimEnter",
	---@module 'which-key'
	---@type wk.Opts
	---@diagnostic disable-next-line: missing-fields
	opts = {
		preset = "modern",
		delay = 0,
		spec = {
			{ "<leader>a", group = "[A]I", mode = { "n", "x" } },
			{ "<leader>b", group = "[B]uffer" },
			{ "<leader>c", group = "[C]ode" },
			{ "<leader>j", group = "[J]ump", mode = { "n", "x", "o" } },
			{ "<leader>p", group = "[P]ersistence/Session" },
			{ "<leader>s", group = "[S]earch", mode = { "n", "x" } },
			{ "<leader>t", group = "[T]oggle" },
			{ "<leader>w", group = "[W]indows" },
			{ "<leader>x", group = "Trouble/Diagnostics" },
			{ "[", group = "Prev" },
			{ "]", group = "Next" },
			{ "s", group = "[S]urround" },
			{ "z", group = "Fold" },
		},
	},
}
