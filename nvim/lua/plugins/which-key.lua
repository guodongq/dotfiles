local wk = require("which-key")
wk.setup({
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object lsp
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object lsp
	-- to enable all native operators, set the preset / operators plugin above
	operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	motions = {
		count = true,
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "double", -- none, single, double, shadow, rounded
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		--padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	--ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
	ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	show_keys = true, -- show the currently pressed key and its label as a message in the command line
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	-- list of triggers, where WhichKey should not wait for timeoutlen and show immediately
	triggers_nowait = {
		-- marks
		"`",
		"'",
		"g`",
		"g'",
		-- registers
		'"',
		"<c-r>",
		-- spelling
		"z=",
	},
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
	-- disable the WhichKey popup for certain buf types and file types.
	-- Disabled by deafult for Telescope
	disable = {
		buftypes = {},
		filetypes = {},
	},
})

-- -----------------------------
-- keybindings Prefix
-- -----------------------------

wk.register({
	b = {
		name = "Buffers",
	},

	c = {
		name = "Compile/Comments",
	},

	d = {
		name = "Debug",
	},

	f = {
		name = "Files",
	},

	g = {
		name = "Git",
	},

	h = {
		name = "Help",
	},

	j = {
		name = "Jump/Join/Split",
	},

	l = {
		name = "LSP",
	},

	q = {
		name = "Quit",
	},

	s = {
		name = "Search/Symbol",
	},

	t = {
		name = "Todo/Terminal",
	},

	w = {
		name = "Windows",
	},
}, { prefix = "<leader>" })

-- -----------------------------
-- keybindings
-- -----------------------------
local mode_adapters = {
	insert_mode = "i",
	normal_mode = "n",
	term_mode = "t",
	visual_mode = "v",
	visual_block_mode = "x",
	command_mode = "c",
	operator_pending_mode = "o",
}

local mappings = {
	normal_mode = {
		-- Buffers
		["<leader>ba"] = { "<cmd>lua require('Buffers').clear()<cr>", "Close all buffers" },
		["<leader>bd"] = { "<cmd>lua require('Buffers').delete()<cr>", "Kill current buffer" },
		["<leader>bD"] = { "<cmd>lua require('Buffers').only()<cr>", "Kill other buffers" },
		["<leader>bl"] = { "<cmd>Telescope buffers path_display={'truncate'}<cr>", "List buffers" },
		["<leader>bn"] = { "<cmd>bn<cr>", "Next buffer" },
		["<leader>bp"] = { "<cmd>bp<cr>", "Previous buffer" },
		["<S-l>"] = { "<cmd>bn<cr>", "Next buffer" },
		["<S-h>"] = { "<cmd>bp<cr>", "Previous buffer" },

		-- Compile/Comments
		["<leader>cb"] = {
			"<cmd>lua require('Comment.api').toggle.blockwise.current()<cr>",
			"comment-or-uncomment-blocks",
		},
		["<leader>co"] = { "<cmd>lua require('Comment.api').insert.linewise.below()<cr>", "comment-line-below" },
		["<leader>cO"] = { "<cmd>lua require('Comment.api').insert.linewise.above()<cr>", "comment-line-above" },
		["<leader>c/"] = {
			"<cmd>lua require('Comment.api').toggle.linewise.current()<cr>",
			"comment-or-uncomment-lines",
		},
		["<leader>c$"] = { "<cmd>lua require('Comment.api').insert.linewise.eol()<cr>", "comment-end-of-line" },

		-- Debug
		["<leader>db"] = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "toggle breakpoint" },
		["<leader>dl"] = { "<cmd>Telescope dap list_breakpoints<cr>", "show all breakpoints" },
		["<leader>dx"] = { "<cmd>lua require('dap').clear_breakpoints()<cr>", "removes all breakpoints" },
		["<leader>du"] = { "<cmd>lua require('dapui').toggle()<cr>", "toggle dapui" },
		["<leader>dq"] = { "<cmd>lua require('dap').terminate()<cr>", "terminate" },
		["F5"] = { "<cmd>lua require('dap').step_into()<cr>", "Step Into(Debugger)" },
		["F6"] = { "<cmd>lua require('dap').step_over()<cr>", "Step Over(Debugger)" },
		["F7"] = { "<cmd>lua require('dap').step_out()<cr>", "Step Out(Debugger)" },
		["F8"] = { "<cmd>lua require('dap').continue()<cr>", "Continue(Debugger)" },
		["F9"] = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "Toggle Breakpoint(Debugger)" },

		-- Files
		["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find files" },
		["<leader>fs"] = { "<cmd>w!<cr>", "Save a file" },
		["<leader>ft"] = { "<cmd>Neotree toggle filesystem<cr>", "File tree" },
		["<leader>fT"] = { "<cmd>Neotree focus filesystem reveal<cr>", "Focus current file in file tree" },

		-- Git
		["<leader>gd"] = { "<cmd>DiffviewOpen<cr>", "Diffview opene" },
		["<leader>gD"] = { "<cmd>DiffviewClose<cr>", "Diffview close" },
		["<leader>gm"] = { "<cmd>GitMessenger<cr>", "Reveal commit messages" },
		["<leader>gh"] = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff this HEAD" },

		-- Help
		["<leader>hr"] = {
			"<cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><cr>",
			"Redraw/Clear hlsearch/Diff update",
		}, -- Clear search, diff update and redraw, taken from runtime/lua/_editor.lua

		-- Jump/Join/Split
		["<leader>j1"] = { "<cmd>HopChar1<cr>", "jump-or-select-to-a-character" },
		["<leader>j2"] = { "<cmd>HopChar2<cr>", "jump-to-suite-of-two-characters" },
		["<leader>jl"] = { "<cmd>HopLine<cr>", "jump-or-select-to-a-line" },
		["<leader>jp"] = { "<cmd>HopPattern<cr>", "jump-or-select-to-a-pattern" },
		["<leader>jw"] = { "<cmd>HopWord<cr>", "jump-to-a-word" },

		-- LSP
		["<leader>lm"] = { "<cmd>Mason<cr>", "Mason" },
		["<leader>lr"] = { "<cmd>lua require('spectre').open()<cr>", "Replace in files (Spectre)" },
		["<leader>lo"] = { "<cmd>SymbolsOutline<cr>", "SymbolsOutline" },

		-- Quit
		["<leader>qq"] = { "<esc><cmd>qa<cr>", "Quit neovim" },

		-- Search/Symbol
		["<leader>sb"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search in current buffer" },
		["<leader>sf"] = { "<cmd>Telescope find_files<cr>", "Search files (root dir)" },
		["<leader>sg"] = { "<cmd>Telescope live_grep<cr>", "Search grep" },
		["<leader>sp"] = { "<cmd>lua require('telescope').extensions.projects.projects{}<cr>", "Search project" },
		["<leader>sr"] = { "<cmd>Telescope oldfiles<cr>", "Search recent" },
		["<leader>st"] = { "<cmd>Telescope<cr>", "Search (Telescope)" },

		-- Todo/Terminal

		-- Windows
		["<leader>wc"] = { "<cmd>lua require('nvim-window').pick()<cr>", "Choose a window" },
		["<leader>wd"] = { "<cmd>wincmd c<cr>", "Close current window" },
		["<leader>wD"] = { "<cmd>wincmd o<cr>", "Close other windows" },
		["<leader>wh"] = { "<cmd>wincmd h<cr>", "Go to the left window" },
		["<leader>wj"] = { "<cmd>wincmd j<cr>", "Go to the down window" },
		["<leader>wk"] = { "<cmd>wincmd k<cr>", "Go to the up window" },
		["<leader>wl"] = { "<cmd>wincmd l<cr>", "Go to the right window" },
		["<leader>wm"] = { "<cmd>lua require('maximizer').toggle()<cr>", "Maximize current window" },
		["<leader>ws"] = { "<cmd>sp<cr>", "Split window" },
		["<leader>wv"] = { "<cmd>vsp<cr>", "Split window vertically" },

		-- General keymaps
		-- better up/down
		["j"] = { "v:count == 0 ? 'gj' : 'j'", "Better down", expr = true },
		["k"] = { "v:count == 0 ? 'gk' : 'k'", "Better up", expr = true },

		["<esc>"] = { "<cmd>noh><cr><esc>", "Escape and clear hlsearch" },
		["<C-a>"] = { "<Esc>gg<S-v>G<CR>", "Select all" },
		["<C-s>"] = { "<cmd>w<cr><esc>", "Save file" },

		-- Move to window using the <ctrl> hjkl keys
		["<C-h>"] = { "<C-w>h", "Go to left window" },
		["<C-j>"] = { "<C-w>j", "Go to lower window" },
		["<C-k>"] = { "<C-w>k", "Go to upper window" },
		["<C-l>"] = { "<C-w>l", "Go to right window" },

		-- Resize window using <ctrl> arrow keys
		["<C-Up>"] = { "<cmd>resize +2<cr>", "Increase window height" },
		["<C-Down>"] = { "<cmd>resize -2<cr>", "Decrease window height" },
		["<C-Left>"] = { "<cmd>vertical resize -2<cr>", "Decrease window width" },
		["<C-Right>"] = { "<cmd>vertical resize +2<cr>", "Increase window width" },

		-- Move Lines
		["<A-j>"] = { "<esc><cmd>m .+1<cr>==gi", "Move lines down" },
		["<A-k>"] = { "<esc><cmd>m .-2<cr>==gi", "Move lines up" },

		["gw"] = { "*N", "Search word under cursor" },

		-- Fix * (Keep the cursor position, don't move to next match)
		["*"] = { "*N", "Keep cursor position" },
		-- Fix n and N. Keeping cursor in center
		["n"] = { "nzz", "Keep cursor in center" },
		["N"] = { "Nzz", "Keep cursor in center" },
	},

	insert_mode = {
		["jk"] = { "<esc>", "Escape" },
		["<esc>"] = { "<cmd>noh><cr><esc>", "Escape and clear hlsearch" },
		["<A-j>"] = { "<esc><cmd>m .+1<cr>==gi", "Move lines down" },
		["<A-k>"] = { "<esc><cmd>m .-2<cr>==gi", "Move lines up" },
		["<C-s>"] = { "<cmd>w<cr><esc>", "Save file" },
	},

	visual_mode = {
		-- Move Lines
		["<A-j>"] = { "<esc><cmd>m .+1<cr>==gi", "Move lines down" },
		["<A-k>"] = { "<esc><cmd>m .-2<cr>==gi", "Move lines up" },
		-- better indenting
		["<"] = { "<gv", "Better indenting" },
		[">"] = { ">gv", "Better indenting" },

		-- git
		["<leader>g"] = { name = "Git/Versions-Control" },
		["<leader>gs"] = { "<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk" },
		["<leader>gr"] = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk" },
	},

	visual_block_mode = {
		["gw"] = { "*N", "Search word under cursor" },

		-- compile/comment
		["<leader>c"] = { name = "Compile/Comment" },
		["<leader>cb"] = {
			"<esc><cmd>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<cr>",
			"comment-or-uncomment-blocks",
		},
		["<leader>c/"] = {
			"<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
			"comment-or-uncomment-lines",
		},
	},

	term_mode = {
		-- normal mode shortcut
		["<esc>"] = { [[<C-\><C-n>]], "Normal Mode" },

		-- window keybindings
		["<C-j>"] = { [[<C-\><C-n><C-w>j]], "Move to Left Window" },
		["<C-k>"] = { [[<C-\><C-n><C-w>k]], "Move to Bottom Window" },
		["<C-h>"] = { [[<C-\><C-n><C-w>h]], "Move to Top Window" },
		["<C-l>"] = { [[<C-\><C-n><C-w>l]], "Move to Right Window" },
		["<C-Up>"] = { [[<C-\><C-n><cmd>resize -2<cr>i]], "Resize Window Up" },
		["<C-Down>"] = { [[<C-\><C-n><cmd>resize +2<cr>i]], "Resize Window Down" },
		["<C-Left>"] = { [[<C-\><C-n><cmd>vertical resize -2<cr>i]], "Resize Window Left" },
		["<C-Right>"] = { [[<C-\><C-n><cmd>vertical resize +2<cr>i]], "Resize Window Right" },
	},
}

for mode, keys in pairs(mappings) do
	local mode_adapter = mode_adapters[mode]
	wk.register(keys, { mode = mode_adapter })
end
