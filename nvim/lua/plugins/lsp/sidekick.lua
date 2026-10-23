-- GitHub Copilot next edit suggestions (NES) and AI CLI integration.
-- Uses the `copilot` LSP enabled in plugins/lsp/servers.lua. First-time setup:
-- run `:LspCopilotSignIn`, then `:checkhealth sidekick`.

---@param method string sidekick.cli function name
---@param opts? table
local function cli(method, opts)
	-- Pass a copy: sidekick.cli modifies the opts table it receives.
	return function() require("sidekick.cli")[method](vim.deepcopy(opts or {})) end
end

return {
	"folke/sidekick.nvim",
	event = "VeryLazy", -- load early so suggestions appear without a keypress first
	opts = {},
	keys = {
		{
			"<tab>",
			function()
				if require("sidekick").nes_jump_or_apply() then
					return ""
				end
				return "<Tab>"
			end,
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
