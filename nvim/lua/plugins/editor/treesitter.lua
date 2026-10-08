local parsers = {
	"bash",
	"c",
	"cpp",
	"css",
	"diff",
	"go",
	"gomod",
	"gowork",
	"html",
	"java",
	"javascript",
	"json",
	"lua",
	"luadoc",
	"markdown",
	"markdown_inline",
	"python",
	"query",
	"regex",
	"scss",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
}

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({ install_dir = vim.fn.stdpath("data") .. "/site" })

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("treesitter-highlight", { clear = true }),
			callback = function(event)
				local lang = vim.treesitter.language.get_lang(event.match) or event.match
				if #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) > 0 then
					vim.treesitter.start(event.buf, lang)
				elseif vim.list_contains(parsers, lang) then
					require("nvim-treesitter").install({ lang })
				end
			end,
		})
	end,
}
