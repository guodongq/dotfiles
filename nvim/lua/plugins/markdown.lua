local M1 = {
	"tpope/vim-markdown",
}

M1.config = function()
	vim.g.markdown_syntax_conceal = 0
	vim.g.markdown_fenced_languages = {
		"python",
		"bash=sh",
		"html",
		"json",
		"java",
		"js=javascript",
		"sql",
		"yaml",
		"xml",
		"Dockerfile",
		"Rust",
		"lua",
		"go",
	}
end

local M2 = {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = "cd app && yarn install",
	ft = { "markdown" },
}

M2.init = function()
	vim.g.mkdp_filetypes = { "markdown" }
end

return { M1, M2 }
