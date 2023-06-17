vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[ ]]

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

local modules = {
    'config.options',
    'config.plugins',
    'config.autocmds'
}

for _, module in ipairs(modules) do
    require(module)
end