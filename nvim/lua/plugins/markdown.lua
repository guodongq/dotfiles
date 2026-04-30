local M = {
	"tpope/vim-markdown",
}

M.config = function()
	vim.g.markdown_syntax_conceal = 0
	vim.g.markdown_fenced_languages = {
		"python", "bash=sh", "html", "json", "java", "js=javascript",
		"sql", "yaml", "xml", "Dockerfile", "Rust", "lua", "go",
	}
end

local M2 = {
	"iamcco/markdown-preview.nvim",
	ft = { "markdown" },
	build = "cd app && yarn install",
}

M2.config = function()
	vim.g.mkdp_filetypes = { "markdown" }
end

return { M, M2 }
