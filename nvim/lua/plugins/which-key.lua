local M = {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		icons = {
			group = "", -- symbol prepended to a group
		},
	},
}

function M.config(_, opts)
	require("which-key").setup(opts)
	require("utils.keymaps-helpers").which_key_register()
end

return M
