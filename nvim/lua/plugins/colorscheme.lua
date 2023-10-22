-- tokyonight
-- local M = {
--    "folke/tokyonight.nvim",
--    lazy = false,
--    priority = 1000,
--    enabled = true,
-- }
-- M.name = "tokyonight"
--
-- function M.config()
--   vim.cmd.colorscheme(M.name)
-- end

-- sakura
local M = {
	"numToStr/Sakura.nvim",
	lazy = false,
	priority = 1000,
}
function M.config()
	require("Sakura").load()
end

return M
