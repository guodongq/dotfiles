local M = { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"HiPhish/rainbow-delimiters.nvim",
	},
	opts = {
		ensure_installed = {
			"bash",
			"c",
			"python",
			"yaml",
			"go",
			"json",
			"diff",
			"html",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"query",
			"vim",
			"vimdoc",
		},
		-- Autoinstall languages that are not installed
		auto_install = true,
		sync_install = true,
		autopairs = { enable = true },
		highlight = {
			enable = true,
			-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
			--  If you are experiencing weird indenting issues, add the language to
			--  the list of additional_vim_regex_highlighting and disabled languages for indent.
			additional_vim_regex_highlighting = { "ruby" },
		},
		indent = { enable = true, disable = { "ruby" } },
	},
}

function M.config(_, opts)
	-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

	---@diagnostic disable-next-line: missing-fields
	require("nvim-treesitter.configs").setup(opts)

	-- There are additional nvim-treesitter modules that you can use to interact
	-- with nvim-treesitter. You should go explore a few and see what interests you:
	--
	--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
	--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
	--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	vim.opt.foldmethod = "expr"
	vim.opt.foldlevel = 99
	vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

	-- This module contains a number of default definitions
	local rainbow_delimiters = require("rainbow-delimiters")

	vim.g.rainbow_delimiters = {
		strategy = {
			[""] = rainbow_delimiters.strategy["global"],
			vim = rainbow_delimiters.strategy["local"],
		},
		query = {
			[""] = "rainbow-delimiters",
			lua = "rainbow-blocks",
		},
		priority = {
			[""] = 110,
			lua = 210,
		},
		highlight = {
			"RainbowDelimiterRed",
			"RainbowDelimiterYellow",
			"RainbowDelimiterBlue",
			"RainbowDelimiterOrange",
			"RainbowDelimiterGreen",
			"RainbowDelimiterViolet",
			"RainbowDelimiterCyan",
		},
	}
end

return M
