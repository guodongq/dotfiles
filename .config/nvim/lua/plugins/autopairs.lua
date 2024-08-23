-- autopairs
-- https://github.com/windwp/nvim-autopairs
local M = {
	"windwp/nvim-autopairs",
	--event = 'InsertEnter',
	event = "VeryLazy",
	-- Optional dependency
	dependencies = { "hrsh7th/nvim-cmp" },
}

function M.config()
	require("nvim-autopairs").setup({})
	-- If you want to automatically add `(` after selecting a function or method
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	local cmp = require("cmp")
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return M
