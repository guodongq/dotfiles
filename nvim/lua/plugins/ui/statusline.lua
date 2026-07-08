local M = {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
}

M.init = function()
	vim.g.lualine_laststatus = vim.o.laststatus
	if vim.fn.argc(-1) > 0 then
		vim.o.statusline = " "
	else
		vim.o.laststatus = 0
	end
end

M.opts = {}

return M
