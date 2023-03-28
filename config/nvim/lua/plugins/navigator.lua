require('Navigator').setup({
    auto_save = 'current',
})

vim.keymap.set({ 'n', 't' }, '<A-h>', '<CMD>lua require("Navigator").left()<CR>')
vim.keymap.set({ 'n', 't' }, '<A-k>', '<CMD>lua require("Navigator").up()<CR>')
vim.keymap.set({ 'n', 't' }, '<A-l>', '<CMD>lua require("Navigator").right()<CR>')
vim.keymap.set({ 'n', 't' }, '<A-j>', '<CMD>lua require("Navigator").down()<CR>')
vim.keymap.set({ 'n', 't' }, '<A-p>', '<CMD>lua require("Navigator").previous()<CR>')