return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = "VeryLazy",
	opts = {
		options = {
			diagnostics = "nvim_lsp",
			-- Unlike :bdelete, Snacks.bufdelete keeps the window layout (e.g. the explorer split).
			close_command = function(buf) Snacks.bufdelete(buf) end,
			right_mouse_command = function(buf) Snacks.bufdelete(buf) end,
			offsets = {
				{ filetype = "NvimTree", text = "File Explorer", highlight = "Directory", separator = true },
			},
		},
	},
}
