-- Leader/local leader - lazy.nvim needs these set first
vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[,]]


vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

require('config.settings')
require('config.autocmds')
require('config.plugins')
