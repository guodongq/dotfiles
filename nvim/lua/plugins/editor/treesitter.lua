local M = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
}

M.opts = {
	ensure_installed = {
		"bash", "c", "cpp", "diff", "html", "java", "javascript",
		"json", "lua", "luadoc", "markdown", "markdown_inline",
		"python", "query", "regex", "toml", "tsx", "typescript",
		"vim", "vimdoc", "yaml", "go", "gomod", "gowork",
		"css", "scss",
	},
	sync_install = false,
	highlight = { enable = true, additional_vim_regex_highlighting = false },
	indent = { enable = true },
	incremental_selection = { enable = true, keymaps = { init_selection = "<C-space>" } },
}

return M
