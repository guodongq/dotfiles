vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[ ]]

local configs = {
    'config.options',
    'config.autocmds',
    'config.plugins',
    'config.keymaps',
}

for _, config in ipairs(configs) do
    require(config)
end