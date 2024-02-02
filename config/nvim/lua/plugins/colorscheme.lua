-- ==================
-- tokyonight
-- ==================
local M = {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = { style = "moon" },
}
M.name = "tokyonight"

function M.config()
	-- vim.opt.background = "light"
	vim.opt.background = "dark"
	vim.cmd.colorscheme(M.name)
end

-- ==================
-- sakura
-- ==================
-- local M = {
-- 	"numToStr/Sakura.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- }
-- function M.config()
-- 	require("Sakura").load()
-- end

return M
