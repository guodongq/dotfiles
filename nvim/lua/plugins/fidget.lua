local M = {
	"j-hui/fidget.nvim",
	tag = "legacy",
	event = "LspAttach",
}

function M.config()
	require("fidget").setup()
end

return M
