local M = {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
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
