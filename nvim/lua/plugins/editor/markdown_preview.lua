-- Live preview of Markdown (also HTML, AsciiDoc and SVG) in the browser; pure Lua, no Node.js.
-- `:LivePreview start` opens the current file, `:LivePreview close` stops the server.
return {
	"brianhuster/live-preview.nvim",
	cmd = "LivePreview",
	keys = {
		{ "<leader>cp", "<cmd>LivePreview start<cr>", ft = "markdown", desc = "Markdown [P]review" },
	},
	-- `:LivePreview pick` uses Snacks, which replaces vim.ui.select. Auto-detection would choose
	-- mini.pick, which comes with mini.nvim but isn't set up here.
	config = function() require("livepreview.config").set({ picker = "vim.ui.select" }) end,
}
