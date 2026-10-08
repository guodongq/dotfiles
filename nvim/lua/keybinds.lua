local map = vim.keymap.set

-- Search and file operations
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("n", "<leader>H", "<cmd>nohlsearch<cr>", { desc = "Clear [H]ighlights" })
map("n", "<leader>S", "<cmd>write<cr>", { desc = "[S]ave file" })
map("n", "<leader>Q", "<cmd>confirm qall<cr>", { desc = "[Q]uit Neovim" })

-- Diagnostics
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
map("n", "]d", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Next [D]iagnostic" })
map("n", "[d", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Prev [D]iagnostic" })

-- Exit terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Split navigation with CTRL+<hjkl>
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Paste from system clipboard in insert mode
map("i", "<D-v>", "<C-r>+", { desc = "Paste from system clipboard" })

-- Window management
map("n", "<leader>wd", "<cmd>wincmd c<cr>", { desc = "[D]elete Current [W]indow" })
map("n", "<leader>wD", "<cmd>wincmd o<cr>", { desc = "[D]elete Other [W]indows" })
map("n", "<leader>ws", "<cmd>sp<cr>", { desc = "[S]plit [W]indow" })
map("n", "<leader>wv", "<cmd>vsp<cr>", { desc = "Split [W]indow [V]ertically" })

-- Buffer navigation
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- Move selected line / block of text
map("v", "<M-j>", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
map("v", "<M-k>", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })
map("n", "<M-j>", ":m .+1<CR>==", { desc = "Move current line down" })
map("n", "<M-k>", ":m .-2<CR>==", { desc = "Move current line up" })
map("i", "<M-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move current line down" })
map("i", "<M-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move current line up" })

-- Better paste (don't yank replaced text)
map("v", "p", '"_dP')

-- Press jk to exit insert mode
map("i", "jk", "<Esc>")
map("i", "<C-c>", "<Esc>")

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Better searching (center screen after search)
map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "*", "*zz")
map("n", "#", "#zz")
map("n", "g*", "g*zz")
map("n", "g#", "g#zz")
