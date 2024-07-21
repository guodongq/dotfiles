local M = {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		-- delete other buffers
		"numToStr/Buffers.nvim",
		-- list buffers
		"nvim-telescope/telescope.nvim",
	},
	keys = {
		{
			"<leader>ba",
			"<cmd>lua require('Buffers').clear()<cr>",
			desc = "Close All Buffers",
			mode = "n",
		},
		{
			"<leader>bd",
			"<cmd>lua require('Buffers').delete()<cr>",
			desc = "Kill Current Buffer",
			mode = "n",
		},
		{
			"<leader>bD",
			"<cmd>BufferLineCloseOthers<cr>",
			desc = "Kill Other Buffers",
			mode = "n",
		},
		{
			"<leader>bn",
			"<cmd>BufferLineCycleNext<cr>",
			desc = "Next Buffer",
			mode = "n",
		},
		{
			"<leader>bp",
			"<cmd>BufferLineCyclePrev<cr>",
			desc = "Previous Buffer",
			mode = "n",
		},
		{
			"<leader>bl",
			"<cmd>Telescope buffers path_display={'truncate'}<cr>",
			desc = "List Buffers",
			mode = "n",
		},
	},
}

M.opts = {
	options = {
		diagnostics = "nvim_lsp",
		separator_style = "thin",
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				text_align = "center",
				highlight = "Directory",
				separator = true,
			},
		},
	},
	highlights = {
		fill = {
			fg = { attribute = "fg", highlight = "TabLine" },
			bg = { attribute = "bg", highlight = "TabLine" },
		},
		background = {
			fg = { attribute = "fg", highlight = "TabLine" },
			bg = { attribute = "bg", highlight = "TabLine" },
		},
		buffer_visible = {
			fg = { attribute = "fg", highlight = "TabLine" },
			bg = { attribute = "bg", highlight = "TabLine" },
		},
		close_button = {
			fg = { attribute = "fg", highlight = "TabLine" },
			bg = { attribute = "bg", highlight = "TabLine" },
		},
		close_button_visible = {
			fg = { attribute = "fg", highlight = "TabLine" },
			bg = { attribute = "bg", highlight = "TabLine" },
		},
		tab_selected = {
			fg = { attribute = "fg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		tab = {
			fg = { attribute = "fg", highlight = "TabLine" },
			bg = { attribute = "bg", highlight = "TabLine" },
		},
		tab_close = {
			-- fg = {attribute='fg',highlight='LspDiagnosticsDefaultError'},
			fg = { attribute = "fg", highlight = "TabLineSel" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		duplicate_selected = {
			fg = { attribute = "fg", highlight = "TabLineSel" },
			bg = { attribute = "bg", highlight = "TabLineSel" },
			italic = true,
		},
		duplicate_visible = {
			fg = { attribute = "fg", highlight = "TabLine" },
			bg = { attribute = "bg", highlight = "TabLine" },
			italic = true,
		},
		duplicate = {
			fg = { attribute = "fg", highlight = "TabLine" },
			bg = { attribute = "bg", highlight = "TabLine" },
			italic = true,
		},
		modified = {
			fg = { attribute = "fg", highlight = "TabLine" },
			bg = { attribute = "bg", highlight = "TabLine" },
		},
		modified_selected = {
			fg = { attribute = "fg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		modified_visible = {
			fg = { attribute = "fg", highlight = "TabLine" },
			bg = { attribute = "bg", highlight = "TabLine" },
		},
		separator = {
			fg = { attribute = "bg", highlight = "TabLine" },
			bg = { attribute = "bg", highlight = "TabLine" },
		},
		separator_selected = {
			fg = { attribute = "bg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		indicator_selected = {
			fg = { attribute = "fg", highlight = "LspDiagnosticsDefaultHint" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
	},
}

function M.config(_, opts)
	require("bufferline").setup(opts)
	-- Fix bufferline when restoring a session
	vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
		callback = function()
			vim.schedule(function()
				---@diagnostic disable-next-line: undefined-global
				pcall(nvim_bufferline)
			end)
		end,
	})
end

return M
