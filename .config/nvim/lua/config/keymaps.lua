-- Options:
--   noremap -> don't map recursively
--   silent  -> don't print output
--   <C-xxx> -> Control + xxx
--   <M-xxx> -> Alt + xxx
--   <S-xxx> -> Shift + xxx
local desc = require("util.kit").desc

local mappings = {
    -- no hl
    { "n", "<ESC>", "<cmd>noh<cr><esc>", desc("Escape and Clear hlsearch") },
    -- Better paste
    { "v", "p", '"_dP', desc() },
    -- Press jk to exit
    { "i", "jk", "<ESC>", desc("Escape") },
    { "i", "<C-c>", "<ESC>", desc() },
    -- Better indenting
    { "v", "<", "<gv", desc() },
    { "v", ">", ">gv", desc() },
    -- Move selected line / block of text
    { "v", "<M-j>", ":m '>+1<CR>gv=gv", desc() },
    { "v", "<M-k>", ":m '<-2<CR>gv=gv", desc() },
    { "n", "<M-j>", ":m .+1<CR>==", desc() },
    { "n", "<M-k>", ":m .-2<CR>==", desc() },
    { "i", "<M-j>", "<Esc>:m .+1<CR>==gi", desc() },
    { "i", "<M-k>", "<Esc>:m .-2<CR>==gi", desc() },
    { "x", "<M-j>", ":m '>+1<CR>gv=gv", desc() },
    { "x", "<M-k>", ":m '<-2<CR>gv=gv", desc() },
    -- Better window navigation
    { "n", "<C-h>", "<cmd>wincmd h<cr>", desc() },
    { "n", "<C-j>", "<cmd>wincmd j<cr>", desc() },
    { "n", "<C-k>", "<cmd>wincmd k<cr>", desc() },
    { "n", "<C-l>", "<cmd>wincmd l<cr>", desc() },
    -- Resize with arrows
    { "n", "<C-Up>", "<cmd>resize -2<cr>", desc("Shrink window horizontally") },
    { "n", "<C-Down>", "<cmd>resize +2<cr>", desc("Increase window horizontally") },
    { "n", "<C-Left>", "<cmd>vertical -2<cr>", desc("Shrink window vertically") },
    { "n", "<C-Right>", "<cmd>vertical +2<cr>", desc("Increase window vertically") },
    -- Buffer navigation
    { "n", "<S-l>", "<cmd>bnext<cr>", desc("Next buffer") },
    { "n", "<S-h>", "<cmd>bprevious<cr>", desc("Previous buffer") },
    { "n", "<S-q>", "<cmd>lua require('Buffers').delete()<cr>", desc("Close Buffer") },
    -- Better searching move
    { "n", "n", "nzz", desc() },
    { "n", "N", "Nzz", desc() },
    { "n", "*", "*zz", desc() },
    { "n", "#", "#zz", desc() },
    { "n", "g*", "g*zz", desc() },
    { "n", "g#", "g#zz", desc() },
}

for _, map in pairs(mappings) do
    vim.keymap.set(unpack(map))
end
