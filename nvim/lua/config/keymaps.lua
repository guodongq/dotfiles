local utils = require("utils.keymaps-helpers")
local maps = utils.empty_map_table()

local sections = {
	b = { desc = "󰆧 Buffer" },
	c = { desc = "󱡠 Comment" },
	d = { desc = " Debug" },
	f = { desc = "󰈙 File" },
	g = { desc = "󰊢 Git" },
	j = { desc = "󰦮 Jump" },
	l = { desc = " LSP" },
	q = { desc = "󰆼 Session" },
	s = { desc = "󰭎 Telescope" },
	w = { desc = " Window" },
	x = { desc = "󰟢 Diagnostic" },
}

----------------------------------------
-- Normal --
----------------------------------------
-- Better window navigation
maps.n["<C-h>"] = { "<C-w>h", desc = "Navigate to the left split" }
maps.n["<C-j>"] = { "<C-w>j", desc = "Navigate to the bottom split" }
maps.n["<C-k>"] = { "<C-w>k", desc = "Navigate to the top split" }
maps.n["<C-l>"] = { "<C-w>l", desc = "Navigate to the right split" }

-- Resize with arrors
maps.n["<C-Up>"] = { "<cmd>resize -2<cr>", desc = "Shrink window horizontally" }
maps.n["<C-Down>"] = { "<cmd>resize +2<cr>", desc = "Increase window horizontally" }
maps.n["<C-Left>"] = { "<cmd>vertical -2<cr>", desc = "Shrink window vertically" }
maps.n["<C-Right>"] = { "<cmd>vertical +2<cr>", desc = "Increase window vertically" }

-- Navigate buffers
maps.n["<S-l>"] = { "<cmd>bnext<cr>", desc = "Next buffer" }
maps.n["<S-h>"] = { "<cmd>bprevious<cr>", desc = "Previous buffer" }

-- Clear highlights
maps.n["<leader>h"] = { "<cmd>nohlsearch<cr>", desc = "Clear highlights" }

-- Close buffer
maps.n["<S-q>"] = { "<cmd>lua require('Buffers').delete()<cr>", desc = "Close buffer" }

-- Save file
maps.n["<C-s>"] = { "<cmd>w!<cr>", desc = "Save a file" }

-- Quit neovim
maps.n["<leader>q"] = { "<esc><cmd>qa<cr>", desc = "Quit neovim" }
----------------------------------------
-- Visual --
----------------------------------------
-- Better paste
maps.v["p"] = { "P", desc = "Better paste" }

-- Stay in indent mode
maps.v["<"] = { "<gv", desc = "Indent to the left" }
maps.v[">"] = { ">lv", desc = "Indent to the right" }

----------------------------------------
-- Insert --
----------------------------------------
-- Press jk fast to ESC
maps.i["jk"] = { "<ESC>", desc = "Better escape" }

----------------------------------------
-- Plugins --
----------------------------------------
-- Buffers
maps.n["<leader>b"] = sections.b
maps.n["<leader>ba"] = { "<cmd>lua require('Buffers').clear()<cr>", desc = "Close all buffers" }
maps.n["<leader>bd"] = { "<cmd>lua require('Buffers').delete()<cr>", desc = "Kill current buffer" }
maps.n["<leader>bD"] = { "<cmd>lua require('Buffers').only()<cr>", desc = "Kill other buffers" }
maps.n["<leader>bn"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" }
maps.n["<leader>bp"] = { "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" }
maps.n["<leader>bl"] = { "<cmd>Telescope buffers path_display={'truncate'}<cr>", desc = "List buffers" }

-- Comment
maps.n["<leader>c"] = sections.c
maps.n["<leader>cb"] =
	{ "<cmd>lua require('Comment.api').toggle.blockwise.current()<cr>", desc = "comment-or-uncomment-blocks" }
maps.n["<leader>co"] = { "<cmd>lua require('Comment.api').insert.linewise.below()<cr>", desc = "comment-line-below" }
maps.n["<leader>c0"] = { "<cmd>lua require('Comment.api').insert.linewise.above()<cr>", desc = "comment-line-above" }
maps.n["<leader>c/"] =
	{ "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>", desc = "comment-line-current" }
maps.n["<leader>c$"] = { "<cmd>lua require('Comment.api').insert.linewise.eol()<cr>", desc = "comment-end-of-line" }
maps.v["<leader>c"] = sections.c
maps.v["<leader>cb"] = {
	"<esc><cmd>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<cr>",
	desc = "comment-or-uncomment-blocks",
}
maps.v["<leader>c/"] = {
	"<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
	desc = "comment-or-uncomment-lines",
}

-- Dap
maps.n["<leader>d"] = sections.d
maps.n["<leader>db"] = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle breakpoint" }
maps.n["<leader>dc"] = { "<cmd>lua require'dap'.continue()<cr>", desc = "Continue" }
maps.n["<leader>di"] = { "<cmd>lua require'dap'.step_into()<cr>", desc = "Step into" }
maps.n["<leader>do"] = { "<cmd>lua require'dap'.step_over()<cr>", desc = "Step over" }
maps.n["<leader>dO"] = { "<cmd>lua require'dap'.step_out()<cr>", desc = "Step out" }
maps.n["<leader>dr"] = { "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Toggle REPL" }
maps.n["<leader>dl"] = { "<cmd>lua require'dap'.run_last()<cr>", desc = "Run last" }
maps.n["<leader>du"] = { "<cmd>lua require'dapui'.toggle()<cr>", desc = "Toggle Dap UI" }
maps.n["<leader>dt"] = { "<cmd>lua require'dap'.terminate()<cr>", desc = "Terminate" }

-- File
maps.n["<leader>f"] = sections.f
maps.n["<leader>fs"] = { "<cmd>w!<cr>", desc = "Save a file" }
-- maps.n["<leader>ff"] = { "gg=G<cr>", desc = "Format file" }

-- Git
maps.n["<leader>g"] = sections.g
maps.n["<leader>gg"] = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", desc = "Lazygit" }
maps.n["<leader>gl"] = { "<cmd>lua require('gitsigns').blame_line()<cr>", desc = "View Git blame" }
maps.n["<leader>gL"] = { "<cmd>lua require('gitsigns').blame_line { full = true }<cr>", desc = "View full Git blame" }
maps.n["<leader>gp"] = { "<cmd>lua require('gitsigns').preview_hunk()<cr>", desc = "Preview Git hunk" }
maps.n["<leader>gh"] = { "<cmd>lua require('gitsigns').reset_hunk()<cr>", desc = "Reset Git hunk" }
maps.n["<leader>gr"] = { "<cmd>lua require('gitsigns').reset_buffer()<cr>", desc = "Reset Git buffer" }
maps.n["<leader>gs"] = { "<cmd>lua require('gitsigns').stage_hunk()<cr>", desc = "Stage Git hunk" }
maps.n["<leader>gS"] = { "<cmd>lua require('gitsigns').stage_buffer()<cr>", desc = "Stage Git buffer" }
maps.n["<leader>gu"] = { "<cmd>lua require('gitsigns').undo_stage_hunk()<cr>", desc = "Unstage Git hunk" }
maps.n["<leader>gd"] = { "<cmd>lua require('gitsigns').diffthis()<cr>", desc = "View Git diff" }
maps.n["]g"] = { "<cmd>lua require('gitsigns').next_hunk()", desc = "Next Git hunk" }
maps.n["[g"] = { "<cmd>lua require('gitsigns').prev_hunk()<cr>", desc = "Previous Git hunk" }

-- Jump
maps.n["<leader>j"] = sections.j
maps.n["<leader>j1"] = { "<cmd>HopChar1<cr>", desc = "jump-or-select-to-a-character" }
maps.n["<leader>j2"] = { "<cmd>HopChar2<cr>", desc = "jump-to-suite-of-two-characters" }
maps.n["<leader>jl"] = { "<cmd>HopLine<cr>", desc = "jump-or-select-to-a-line" }
maps.n["<leader>jp"] = { "<cmd>HopPattern<cr>", desc = "jump-or-select-to-a-pattern" }
maps.n["<leader>jw"] = { "<cmd>HopWord<cr>", desc = "jump-to-a-word" }

-- Lsp
maps.n["<leader>l"] = sections.l
maps.n["<leader>lf"] = { "<cmd>lua vim.lsp.buf.format({async = true})<cr>", desc = "Format file" }
maps.n["<leader>lo"] = { "<cmd>SymbolsOutline<cr>", desc = "Outline" }
maps.n["<leader>lR"] = { "<cmd>lua require('spectre').open()<cr>", desc = "Spectre" }

-- NvimTree
maps.n["<leader>e"] = { "<cmd>NvimTreeToggle<cr>", desc = "Toggle explorer" }

-- Session
-- maps.n["<leader>q"] = sections.q
-- maps.n["<leader>qq"] = { "<esc><cmd>qa<cr>", desc = "Quit neovim" }
-- maps.n["<leader>qs"] = { "<cmd>lua require('persistence').load()<cr>", desc = "Restore session for current directory" }
-- maps.n["<leader>ql"] = { "<cmd>lua require('persistence').load({last = true})<cr>", desc = "Restore last session" }
-- maps.n["<leader>qd"] = { "<cmd>lua require('persistence').stop()<cr>", desc = "Stop persistence" }

-- Telescope
maps.n["<leader>s"] = sections.s
maps.n["<leader>sb"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in current buffer" }
maps.n["<leader>sf"] = { "<cmd>Telescope find_files<cr>", desc = "Search files" }
maps.n["<leader>sp"] = { "<cmd>lua require('telescope').extensions.projects.projects{}<cr>", desc = "Search projects" }
maps.n["<leader>sr"] = { "<cmd>Telescope oldfiles<cr>", desc = "Search recent" }
maps.n["<leader>ss"] = { "<cmd>Telescope<cr>", desc = "Search(Telescope)" }
maps.n["<leader>st"] = { "<cmd>Telescope live_grep<cr>", desc = "Search words" }

-- Window move
maps.n["<leader>w"] = sections.w
maps.n["<leader>wd"] = { "<cmd>wincmd c<cr>", desc = "Close current window" }
maps.n["<leader>wD"] = { "<cmd>wincmd o<cr>", desc = "Close other windows" }
maps.n["<leader>wh"] = { "<cmd>wincmd h<cr>", desc = "Go to the left window" }
maps.n["<leader>wj"] = { "<cmd>wincmd j<cr>", desc = "Go to the down window" }
maps.n["<leader>wk"] = { "<cmd>wincmd k<cr>", desc = "Go to the up window" }
maps.n["<leader>wl"] = { "<cmd>wincmd l<cr>", desc = "Go to the right window" }
maps.n["<leader>ws"] = { "<cmd>sp<cr>", desc = "Split window" }
maps.n["<leader>wv"] = { "<cmd>vsp<cr>", desc = "Split window vertically" }
maps.n["<leader>wm"] = { "<cmd>lua require('maximizer').toggle()<cr>", desc = "Maximize current window" }
maps.n["<leader>wc"] = { "<cmd>lua require('nvim-window').pick()<cr>", desc = "Pick a window" }

-- Diagnostic
maps.n["<leader>x"] = sections.x
maps.n["<leader>xt"] = { "<cmd>TodoQuickFix<cr>", desc = "Todo toggle" }
maps.n["<leader>xq"] = { "<cmd>TroubleToggle<cr>", desc = "Trouble toggle" }

utils.set_mappings(maps)
