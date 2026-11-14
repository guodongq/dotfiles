-- Editor keymaps. Plugin keymaps live with their plugin in lua/plugins/.
local map = vim.keymap.set

-- General
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Insert and terminal mode
map("i", "jk", "<Esc>")
map("i", "<C-c>", "<Esc>") -- unlike plain <C-c>, this triggers InsertLeave
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Windows
map("n", "<C-h>", "<C-w>h", { desc = "Focus left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus right window" })

-- Buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Editing
map("x", "p", "P", { desc = "Paste without yanking the selection" })
map("x", "<", "<gv", { desc = "Indent left and reselect" })
map("x", ">", ">gv", { desc = "Indent right and reselect" })

-- Keep search matches centered; zv opens folds, which 'foldopen' skips in mappings.
for _, key in ipairs({ "n", "N", "*", "#", "g*", "g#" }) do
	map("n", key, key .. "zzzv")
end
