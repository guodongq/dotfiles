return {
	{
		"numToStr/Buffers.nvim",
		event = "VeryLazy",
		keys = {
			{"<leader>ba", "<cmd>lua require('Buffers').clear()<cr>", desc = "Close all buffers" },
			{"<leader>bd", "<cmd>lua require('Buffers').delete()<cr>", desc = "Kill current buffer" },
			{"<leader>bD", "<cmd>lua require('Buffers').only()<cr>", desc = "Kill other buffers" },
	  },
  },
	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		event = "VeryLazy",
    opts = {
      options = {
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "center",
            separator = true
          }
        },
      },
    },
		keys = {
			{"<leader>bn", "<cmd>bn<cr>", desc="Next buffer"},
			{"<leader>bp", "<cmd>bp<cr>", desc="Previous buffer"},
			{"<leader>bl", "<cmd>Telescope buffers path_display={'truncate'}<cr>", desc="List buffers"},
		},
	}
}

