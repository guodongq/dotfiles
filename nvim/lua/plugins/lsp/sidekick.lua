-- GitHub Copilot integration via sidekick.nvim
-- Requires the `copilot` LSP server (enabled in plugins/lsp/servers.lua).
-- First-time setup: run `:LspCopilotSignIn` to authenticate, then `:checkhealth sidekick`.

local M = {
	"folke/sidekick.nvim",
	opts = {
		cli = {
			-- use telescope for tool/file/prompt pickers (snacks.nvim isn't installed)
			picker = "telescope",
		},
	},
	keys = {
		{
			"<tab>",
			function()
				-- jump to / apply the next edit suggestion, otherwise fall back to a normal <Tab>
				if not require("sidekick").nes_jump_or_apply() then
					return "<Tab>"
				end
			end,
			mode = { "n", "i" },
			expr = true,
			desc = "Sidekick: Goto/Apply Next Edit Suggestion",
		},
		{ "<c-.>", function() require("sidekick.cli").focus() end, mode = { "n", "t", "i", "x" }, desc = "Sidekick: Focus CLI" },
		{ "<leader>aa", function() require("sidekick.cli").toggle() end, desc = "[A]I: Toggle CLI" },
		{ "<leader>ac", function() require("sidekick.cli").toggle({ name = "copilot", focus = true }) end, desc = "[A]I: Toggle [C]opilot CLI" },
		{ "<leader>as", function() require("sidekick.cli").select() end, desc = "[A]I: [S]elect CLI Tool" },
		{ "<leader>ad", function() require("sidekick.cli").close() end, desc = "[A]I: [D]etach CLI Session" },
		{ "<leader>ap", function() require("sidekick.cli").prompt() end, mode = { "n", "x" }, desc = "[A]I: Select [P]rompt" },
		{ "<leader>af", function() require("sidekick.cli").send({ msg = "{file}" }) end, desc = "[A]I: Send [F]ile" },
		{ "<leader>at", function() require("sidekick.cli").send({ msg = "{this}" }) end, mode = { "n", "x" }, desc = "[A]I: Send [T]his" },
		{ "<leader>av", function() require("sidekick.cli").send({ msg = "{selection}" }) end, mode = { "x" }, desc = "[A]I: Send [V]isual Selection" },
	},
}

return M
