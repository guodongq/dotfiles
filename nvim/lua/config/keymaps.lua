-- Editor keymaps. Plugin keymaps live in their spec under lua/plugins/; LSP and
-- diagnostic defaults (grn, gra, grr, gri, gO, K, [d, ]d, ...) come from Nvim.
local map = vim.keymap.set

-- General
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
map("n", "<leader>S", "<cmd>write<cr>", { desc = "[S]ave file" })
map("n", "<leader>Q", "<cmd>confirm qall<cr>", { desc = "[Q]uit Neovim" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic [Q]uickfix list" })

-- Insert and terminal mode
map("i", "jk", "<Esc>")
map("i", "<C-c>", "<Esc>") -- unlike plain <C-c>, this triggers InsertLeave
map("i", "<D-v>", "<C-r>+", { desc = "Paste from system clipboard" }) -- GUI (Neovide)
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Windows
map("n", "<C-h>", "<C-w>h", { desc = "Focus left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus right window" })
map("n", "<leader>ws", "<C-w>s", { desc = "[S]plit window" })
map("n", "<leader>wv", "<C-w>v", { desc = "Split window [V]ertically" })
map("n", "<leader>wd", "<C-w>c", { desc = "[D]elete window" })
map("n", "<leader>wD", "<C-w>o", { desc = "[D]elete other windows" })

-- Buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Editing
map("x", "p", "P", { desc = "Paste without yanking the selection" })
map("x", "<", "<gv", { desc = "Indent left and reselect" })
map("x", ">", ">gv", { desc = "Indent right and reselect" })
map("n", "<M-j>", "<cmd>move .+1<cr>==", { desc = "Move line down" })
map("n", "<M-k>", "<cmd>move .-2<cr>==", { desc = "Move line up" })
map("i", "<M-j>", "<Esc><cmd>move .+1<cr>==gi", { desc = "Move line down" })
map("i", "<M-k>", "<Esc><cmd>move .-2<cr>==gi", { desc = "Move line up" })
map("x", "<M-j>", ":move '>+1<cr>gv=gv", { desc = "Move selection down" })
map("x", "<M-k>", ":move '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Keep search matches centered; zv opens folds, which 'foldopen' skips in mappings.
for _, key in ipairs({ "n", "N", "*", "#", "g*", "g#" }) do
	map("n", key, key .. "zzzv")
end
