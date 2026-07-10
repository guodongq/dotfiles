local M = {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	version = "*",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	keys = {
		{ "<leader>bn", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
		{ "<leader>bp", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
		{ "<leader>bd", "<cmd>BufferLinePickClose<cr>", desc = "Close Buffer" },
		{ "<leader>bl", function() require("telescope.builtin").buffers() end, desc = "List Buffers" },
		{ "<leader>bD", "<cmd>%bd|e#|bd#<cr>", desc = "Close All Buffers" },
	},
}

M.opts = {
	options = {
		diagnostics = "nvim_lsp",
		separator_style = "thin",
		offsets = {
			{ filetype = "NvimTree", text = "Explorer", highlight = "Directory", separator = true, text_align = "center" },
		},
	},
}

return M
