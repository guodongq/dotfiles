vim.loader.enable()
if vim.g.vscode ~= nil then
  return require('vscode')
end
require('settings')
require('autocmd')
require('plugins')
