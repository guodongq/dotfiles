-- Leader key (must be set before plugins load, see `:help mapleader`)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if a Nerd Font is installed and selected in the terminal
vim.g.have_nerd_font = false

-- True color support (colorscheme loads before nvim-tree would otherwise set this)
vim.o.termguicolors = true

-- See `:help option-list`
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.showmode = false

-- Sync OS clipboard; scheduled after UiEnter so it doesn't slow startup
vim.schedule(function() vim.o.clipboard = "unnamedplus" end)

vim.o.breakindent = true
vim.o.undofile = true

-- Case-insensitive search, unless the pattern has a capital letter
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.splitright = true
vim.o.splitbelow = true

-- Show whitespace characters (see `:help listchars`)
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.o.inccommand = "split"
vim.o.cursorline = true
vim.o.scrolloff = 10

-- Prompt to save instead of failing on unsaved changes (e.g. `:q`)
vim.o.confirm = true

-- Folding (use treesitter-based folding when available)
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Persistent undo directory (ensure undofile works across sessions)
local undodir = vim.fn.stdpath('state') .. '/undo'
if vim.fn.isdirectory(undodir) == 0 then vim.fn.mkdir(undodir, 'p') end
vim.o.undodir = undodir

-- Toggle relative number: on in Normal, off in Insert to reduce distraction
vim.api.nvim_create_autocmd('InsertEnter', { callback = function() vim.o.relativenumber = false end })
vim.api.nvim_create_autocmd('InsertLeave', { callback = function() vim.o.relativenumber = true end })

-- Diagnostics display configuration
vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },
	virtual_text = { spacing = 4, prefix = '●', severity = { min = vim.diagnostic.severity.ERROR } },
	virtual_lines = false,
	jump = { float = true },
})