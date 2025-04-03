return {
	{ -- Markdown highlight
		"tpope/vim-markdown",
		config = function()
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
		end,
	},
	{ -- Markdown preview
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
}

