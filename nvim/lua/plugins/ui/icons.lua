-- Icon provider for nvim-tree, telescope, bufferline, lualine.
-- Mocks the nvim-web-devicons API so those plugins work unmodified while only
-- mini.icons is actually installed (one less plugin to track).
local M = {
	"nvim-mini/mini.icons",
	lazy = true,
	opts = {
		style = vim.g.have_nerd_font and "glyph" or "ascii",
	},
}

M.init = function()
	package.preload["nvim-web-devicons"] = function()
		require("mini.icons").mock_nvim_web_devicons()
		return package.loaded["nvim-web-devicons"]
	end
end

return M
