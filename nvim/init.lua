vim.loader.enable()

-- VSCode Neovim: only keymaps; VSCode provides the UI and language features.
if vim.g.vscode then
	require("config.vscode")
	return
end

require("config.options")
require("config.lazy")
require("config.autocmds")
require("config.keymaps")
