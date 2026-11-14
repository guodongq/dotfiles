-- Copilot suggestions and CLI, via sidekick.nvim.
-- First run `:LspCopilotSignIn`, then `:checkhealth sidekick`.

return {
	"folke/sidekick.nvim",
	event = "VeryLazy", -- load early so suggestions show up before the first keypress
	opts = {},
	keys = {
		{
			"<tab>",
			function() return require("sidekick").nes_jump_or_apply() and "" or "<Tab>" end,
			expr = true,
			desc = "Sidekick: Goto/Apply Next Edit Suggestion",
		},
		{
			"<leader>ac",
			function() require("sidekick.cli").toggle({ name = "copilot", focus = true }) end,
			desc = "Copilot CLI",
		},
		{
			"<leader>ap",
			function() require("sidekick.cli").prompt() end,
			mode = { "n", "x" },
			desc = "AI prompt / context",
		},
	},
}
