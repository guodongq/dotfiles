vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[ ]]

local modules = {
    'config.options',
    'config.plugins',
    'config.autocmds'
}

for _, module in ipairs(modules) do
    require(module)
end