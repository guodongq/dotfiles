-- Set leaders before loading plugins.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Appearance
vim.g.have_nerd_font = true
vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.showmode = false
vim.o.breakindent = true
vim.o.signcolumn = "yes"
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Editing
vim.o.undofile = true
vim.o.confirm = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Defer clipboard integration so it doesn't slow startup.
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

-- Search: capitals in the pattern opt into case-sensitive matching.
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = "split"

-- Windows and folds
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Diagnostics
vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },
	virtual_text = { spacing = 4, prefix = "●", severity = { min = vim.diagnostic.severity.ERROR } },
	virtual_lines = false,
	-- `jump.float` was renamed to `jump.on_jump` in Nvim 0.11 (removed in 0.14)
	jump = {
		on_jump = function(_, bufnr)
			vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
		end,
	},
})
