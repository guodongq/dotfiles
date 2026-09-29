local M = {
	"saghen/blink.cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	version = "1.*",
}

---@module 'blink.cmp'
---@type blink.cmp.Config
M.opts = {
	keymap = {
		preset = "default",
		["<CR>"] = { "accept", "fallback" },
		["<Tab>"] = {
			"snippet_forward",
			function()
				return require("sidekick").nes_jump_or_apply()
			end,
			"fallback",
		},
	},
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 200 },
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	signature = { enabled = true },
}

return M
