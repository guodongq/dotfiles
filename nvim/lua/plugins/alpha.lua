return {
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		config = function()
		  local configs = require("alpha.themes.startify").config
			--local configs = require("alpha.themes.dashboard").config
			require("alpha").setup(configs)
		end,
	}
}
