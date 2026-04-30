local M = {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	enabled = true,
	version = "*",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		"numToStr/Buffers.nvim",
		"nvim-telescope/telescope.nvim",
	},
	keys = {
		{ "<leader>bn", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
		{ "<leader>bp", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
		{ "<leader>bd", "<cmd>BufferLinePickClose<cr>", desc = "Close Buffer" },
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

M.config = function(_, opts)
	require("bufferline").setup(opts)
end

return M
