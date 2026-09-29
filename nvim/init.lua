vim.loader.enable()
if vim.g.vscode == true or vim.g.vscode == 1 then
	return require("vscode")
end
require("settings")
require("autocmds")
require("plugins")
require("keybinds")
