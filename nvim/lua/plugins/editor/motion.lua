-- Search-label motion with treesitter integration (replaces hop.nvim).
-- Bound under <leader>j* instead of flash's default bare `s`/`S`, since `s`
-- is already used by mini.surround.
local M = {
	"folke/flash.nvim",
	event = "VeryLazy",
	---@type Flash.Config
	opts = {
		modes = {
			-- Restrict f/F/t/T to the current line only, matching vanilla Vim
			-- behavior (flash.nvim defaults to jumping across lines).
			char = {
				multi_line = false,
				-- Don't dim the rest of the buffer when using f/F/t/T.
				highlight = { backdrop = false },
			},
		},
	},
	keys = {
		{ "<leader>jw", function() require("flash").jump() end, mode = { "n", "x", "o" }, desc = "[J]ump To [W]ord" },
		{ "<leader>jt", function() require("flash").treesitter() end, mode = { "n", "x", "o" }, desc = "[J]ump [T]reesitter Node" },
	},
}

return M