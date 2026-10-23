-- Jump anywhere with search labels. Bound under <leader>j instead of flash's
-- default `s`/`S`, because mini.surround uses `s`.
return {
	"folke/flash.nvim",
	event = "VeryLazy",
	---@type Flash.Config
	opts = {
		-- Keep f/F/t/T on the current line like vanilla Vim, without dimming the buffer.
		modes = { char = { multi_line = false, highlight = { backdrop = false } } },
	},
	keys = {
		{ "<leader>jw", function() require("flash").jump() end, mode = { "n", "x", "o" }, desc = "[J]ump To [W]ord" },
		{
			"<leader>jt",
			function() require("flash").treesitter() end,
			mode = { "n", "x", "o" },
			desc = "[J]ump [T]reesitter Node",
		},
	},
}
