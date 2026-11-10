vim.loader.enable()

-- Inside VSCode only load keymaps; VSCode provides the UI and language features.
if vim.g.vscode then
	require("config.vscode")
	return
end

require("config.options") -- first, so <leader> is set before plugins map keys
require("config.lazy")
require("config.autocmds")
require("config.keymaps")
