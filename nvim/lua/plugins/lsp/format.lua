return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	cmd = "ConformInfo",
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true })
			end,
			desc = "[F]ormat",
		},
	},
	opts = {
		format_on_save = {
			timeout_ms = 1000,
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			c = { "clang_format" },
			css = { "prettier" },
			go = { "gofumpt", "goimports" },
			javascript = { "prettier" },
			json = { "prettier" },
			lua = { "stylua" },
			markdown = { "prettier" },
			proto = { "buf" },
			python = { "ruff_format" },
			typescript = { "prettier" },
			yaml = { "prettier" },
		},
	},
}
