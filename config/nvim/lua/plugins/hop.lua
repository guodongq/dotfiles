require('hop').setup()

vim.keymap.set('n', '<leader>jc', '<CMD>HopChar1<CR>')
vim.keymap.set('n', '<leader>jC', '<CMD>HopChar2<CR>')
vim.keymap.set('n', '<leader>jl', '<CMD>HopLine<CR>')
vim.keymap.set('n', '<leader>jp', '<CMD>HopPattern<CR>')
vim.keymap.set('n', '<leader>jw', '<CMD>HopWord<CR>')