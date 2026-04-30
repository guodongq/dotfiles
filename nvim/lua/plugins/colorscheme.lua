local M = {
	"folke/tokyonight.nvim",
	priority = 1000,
}

M.config = function()
	---@diagnostic disable-next-line: missing-fields
	require("tokyonight").setup({
		styles = {
			comments = { italic = false },
		},
	})
	vim.cmd.colorscheme("tokyonight")
end

return M
