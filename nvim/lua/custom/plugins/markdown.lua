-- markdown-preview is a Neovim plugin to preview markdown files
return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = "cd app && yarn install",
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
	end,
	ft = { "markdown" },
	keys = {
		{ "<leader>tm", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown: [T]oggle [M]arkdown" },
	},
}
