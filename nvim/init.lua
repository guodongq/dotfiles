local g = vim.g

-- Map space to leader
--vim.api.nvim_set_keymap('n', '<space>', '<nop>')
--vim.api.nvim_set_keymap('v', '<space>', '<nop>')
g.mapleader = ' '
g.maplocalleader = ' '

require('config.settings')
require('config.autocmds')
require('config.plugins')
