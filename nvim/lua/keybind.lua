-- See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostics
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Split navigation with CTRL+<hjkl>
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Paste from system clipboard in insert mode
vim.keymap.set("i", "<D-v>", "<C-r>+", { noremap = true, desc = "Paste from system clipboard" })

-- Window management
vim.keymap.set("n", "<leader>wd", "<cmd>wincmd c<cr>", { desc = "[D]elete Current [W]indow" })
vim.keymap.set("n", "<leader>wD", "<cmd>wincmd o<cr>", { desc = "[D]elete Other [W]indows" })
vim.keymap.set("n", "<leader>ws", "<cmd>sp<cr>", { desc = "[S]plit [W]indow" })
vim.keymap.set("n", "<leader>wv", "<cmd>vsp<cr>", { desc = "Split [W]indow [V]ertically" })

-- Buffer navigation
vim.keymap.set("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- Move selected line / block of text
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })
vim.keymap.set("n", "<M-j>", ":m .+1<CR>==", { desc = "Move current line down" })
vim.keymap.set("n", "<M-k>", ":m .-2<CR>==", { desc = "Move current line up" })
vim.keymap.set("i", "<M-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move current line down in insert mode" })
vim.keymap.set("i", "<M-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move current line up in insert mode" })
vim.keymap.set("x", "<M-j>", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down in visual mode" })
vim.keymap.set("x", "<M-k>", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up in visual mode" })

-- Better paste (don't yank replaced text)
vim.keymap.set("v", "p", '"_dP')

-- Press jk to exit insert mode
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Better searching (center screen after search)
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "*", "*zz")
vim.keymap.set("n", "#", "#zz")
vim.keymap.set("n", "g*", "g*zz")
vim.keymap.set("n", "g#", "g#zz")