-- mini.nvim: text objects (ai), surround, autopairs and icons.
return {
	"nvim-mini/mini.nvim",
	lazy = false,
	init = function()
		-- Serve plugins that ask for nvim-web-devicons (nvim-tree, bufferline, lualine) from mini.icons.
		package.preload["nvim-web-devicons"] = function()
			require("mini.icons").mock_nvim_web_devicons()
			return package.loaded["nvim-web-devicons"]
		end
	end,
	config = function()
		require("mini.ai").setup({ n_lines = 500 })
		require("mini.surround").setup()
		require("mini.pairs").setup()
		require("mini.icons").setup()
	end,
}
