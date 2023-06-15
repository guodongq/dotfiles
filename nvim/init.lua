vim.loader.enable()

if vim.g.vscode ~= nil then
    require('config.vscode')
end

local modules = {
    'config.options',
    'config.plugins',
    'config.autocmds',
}

for _, module in ipairs(modules) do
    require(module)
end