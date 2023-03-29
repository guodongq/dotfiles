vim.keymap.set('n', '<leader>bd', '<CMD>lua require("Buffers").delete()<CR>')
vim.keymap.set('n', '<leader>bD', '<CMD>lua require("Buffers").only()<CR>')
vim.keymap.set('n', '<leader>ba', '<CMD>lua require("Buffers").clear()<CR>')
