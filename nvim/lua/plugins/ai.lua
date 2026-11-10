-- AI: Copilot next edit suggestions and AI CLIs in a terminal, via sidekick.nvim.
-- First run `:LspCopilotSignIn`, then `:checkhealth sidekick`.

-- sidekick.cli modifies the opts it receives, so each call gets a fresh copy.
local function cli(method, opts)
	return function() require("sidekick.cli")[method](vim.deepcopy(opts or {})) end
end

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
		{ "<c-.>", cli("focus"), mode = { "n", "t", "i", "x" }, desc = "Sidekick: Focus CLI" },
		{ "<leader>aa", cli("toggle"), desc = "[A]I: Toggle CLI" },
		{ "<leader>ac", cli("toggle", { name = "copilot", focus = true }), desc = "[A]I: Toggle [C]opilot CLI" },
		{ "<leader>as", cli("select"), desc = "[A]I: [S]elect CLI Tool" },
		{ "<leader>ad", cli("close"), desc = "[A]I: [D]etach CLI Session" },
		{ "<leader>ap", cli("prompt"), mode = { "n", "x" }, desc = "[A]I: Select [P]rompt" },
		{ "<leader>af", cli("send", { msg = "{file}" }), desc = "[A]I: Send [F]ile" },
		{ "<leader>at", cli("send", { msg = "{this}" }), mode = { "n", "x" }, desc = "[A]I: Send [T]his" },
		{ "<leader>av", cli("send", { msg = "{selection}" }), mode = "x", desc = "[A]I: Send [V]isual Selection" },
	},
}
