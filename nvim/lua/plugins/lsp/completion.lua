return {
	"saghen/blink.cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	version = "1.*",
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "default",
			["<CR>"] = { "accept", "fallback" },
			-- Snippet jump first, then Sidekick's next edit suggestion, then a literal <Tab>.
			["<Tab>"] = { "snippet_forward", function() return require("sidekick").nes_jump_or_apply() end, "fallback" },
		},
		completion = { documentation = { auto_show = true, auto_show_delay_ms = 200 } },
		signature = { enabled = true },
	},
}
