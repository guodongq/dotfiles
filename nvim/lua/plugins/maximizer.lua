local M = {
	"0x00-ketsu/maximizer.nvim",
	event = "VeryLazy",
}

function M.config()
	require("maximizer").setup({})
end

return M
