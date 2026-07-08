local M = {
	"echasnovski/mini.nvim",
	event = { "BufReadPost", "BufNewFile", "InsertEnter" },
}

M.config = function()
	require("mini.ai").setup({ n_lines = 500 })
	require("mini.surround").setup()
	require("mini.pairs").setup()
end

return M