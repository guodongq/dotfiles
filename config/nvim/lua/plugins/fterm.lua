vim.keymap.set('n', '<C-\\>', "<CMD>lua require('FTerm').toggle()<CR>")
vim.keymap.set('t', '<C-\\>', "<C-\\><C-n><CMD>lua require('FTerm').toggle()<CR>")