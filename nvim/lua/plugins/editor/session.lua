-- Remembers open files/layout per project directory.
local M = {
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = {},
	keys = {
		{ "<leader>ps", function() require("persistence").load() end, desc = "Session: Restore" },
		{ "<leader>pl", function() require("persistence").load({ last = true }) end, desc = "Session: Restore Last" },
		{ "<leader>pd", function() require("persistence").stop() end, desc = "Session: Don't Save" },
	},
}

return M
