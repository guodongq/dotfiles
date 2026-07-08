vim.loader.enable()
if vim.g.vscode ~= nil then
    return require('neovscode')
end
require('setting')
require('autocmd')
require('plugin')
require('keybind')