-- normal_mode = "n",
-- insert_mode = "i",
-- visual_mode = "v",
-- visual_block_mode = "x",
-- term_mode = "t",
-- command_mode = "c",

local map = function(mode, lhs, rhs, desc)
	if desc then
		desc = desc
	end

	vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, noremap = true })
end

-- Remap space as leader key
map("", "<Space>", "<Nop>")

----------------------------------------
-- Normal --
----------------------------------------
-- Better window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resize with arrors
map("n", "<C-Up>", ":resize +2<CR>", "Increase window height")
map("n", "<C-Down>", ":resize -2<CR>", "Decrease window height")
map("n", "<C-Left>", ":vertical resize -2<CR>", "Decrease window width")
map("n", "<C-Right>", ":vertical resize +2<CR>", "Increase window width")

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")

-- Move text up and down
map("n", "<A-j>", "<esc><cmd>m .+1<CR>==gi", "Move lines down")
map("n", "<A-K>", "<esc><cmd>m .-2<CR>==gi", "Move lines up")

-- Window move
map("n", "<leader>wd", "<cmd>wincmd c<cr>", "Close current window")
map("n", "<leader>wD", "<cmd>wincmd o<cr>", "Close other windows")
map("n", "<leader>wh", "<cmd>wincmd h<cr>", "Go to the left window")
map("n", "<leader>wj", "<cmd>wincmd j<cr>", "Go to the down window")
map("n", "<leader>wk", "<cmd>wincmd k<cr>", "Go to the up window")
map("n", "<leader>wl", "<cmd>wincmd l<cr>", "Go to the right window")
map("n", "<leader>ws", "<cmd>sp<cr>", "Split window")
map("n", "<leader>wv", "<cmd>vsp<cr>", "Split window vertically")

-- Save file
map("n", "<leader>fs", "<cmd>w!<cr>", "Save a file")

-- Help
map("n", "<leader>hr", "<cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><cr>", "Redraw/Clear hlsearch/Diff update")

-- Quit
map("n", "<leader>qq", "<esc><cmd>qa<cr>", "Quit neovim")

-- Better up/down
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Better down", expr = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Better up", expr = true })

-- Escape and clear hlsearch
map("n", "<esc>", "<cmd>noh><cr><esc>", "Escape and clear hlsearch")

-- Select all & Save file
map("n", "<C-a>", "<esc>gg<S-v>G<cr>", "Select all")
map("n", "<C-s>", "<cmd>w<cr><esc>", "Save file")

-- Search word under cursor
map("n", "gw", "*N", "Search word under cursor")

-- Fix * (Keep the cursor position, don't move to next match)
map("n", "*", "*N", "Keep cursor position")

-- Fix n and N. Keeping cursor in center
map("n", "n", "nzz", "Keep cursor in center")
map("n", "N", "Nzz", "Keep cursor in center")

----------------------------------------
-- Insert --
----------------------------------------
-- Press jk fast to exit insert mode
map("i", "jk", "<ESC>")
map("i", "kj", "<ESC>")

map("i", "<esc>", "<cmd>noh><cr><esc>", "Escape and clear hlsearch")
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", "Move lines down")
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", "Move lines up")
map("i", "<C-s>", "<cmd>w<cr><esc>", "Save file")

----------------------------------------
-- Visual --
----------------------------------------
-- Stay in indent mode
map("v", "<", "<gv^")
map("v", ">", ">gv^")

-- Move test up and down
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")
map("v", "p", '"_dP')

----------------------------------------
-- Visual Block --
----------------------------------------
-- Move text up and down
map("x", "J", ":m '>+1<CR>gv=gv")
map("x", "K", ":m '<-2<CR>gv=gv")
map("x", "<A-j>", ":m '>+1<CR>gv=gv")
map("x", "<A-k>", ":m '<-2<CR>gv=gv")
map("x", "gw", "*N", "Search word under cursor")

----------------------------------------
-- Terminal --
----------------------------------------
map("t", "<esc>", "[[<C-\\><C-n>]]", "Normal mode")
map("t", "<C-j>", "[[<C-\\><C-n><C-w>j]]", "Move to left window")
map("t", "<C-k>", "[[<C-\\><C-n><C-w>k]]", "Move to bottom window")
map("t", "<C-h>", "[[<C-\\><C-n><C-w>h]]", "Move to top window")
map("t", "<C-l>", "[[<C-\\><C-n><C-w>l]]", "Move to right window")
map("t", "<C-Up>", "[[<C-\\><C-n><cmd>resize -2<cr>i]]", "Resize window up")
map("t", "<C-Down>", "[[<C-\\><C-n><cmd>resize +2<cr>i]]", "Resize window down")
map("t", "<C-Left>", "[[<C-\\><C-n><cmd>vertical resize -2<cr>i]]", "Resize window left")
map("t", "<C-Right>", "[[<C-\\><C-n><cmd>vertical resize +2<cr>i]]", "Resize window right")
