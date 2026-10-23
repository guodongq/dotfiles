-- Set leaders before plugins load so their keymaps use them.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Appearance
vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.showmode = false -- the statusline shows the mode
vim.o.breakindent = true
vim.o.scrolloff = 10
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Editing
vim.o.mouse = "a"
vim.o.undofile = true
vim.o.confirm = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
-- Deferred because loading the clipboard provider slows startup.
vim.schedule(function() vim.o.clipboard = "unnamedplus" end)

-- Search: ignore case unless the pattern contains capitals.
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = "split"

-- Windows and folds
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99 -- open all folds by default

-- Filetypes
vim.filetype.add({
	extension = { mdx = "markdown", mjml = "html", kicad_mod = "scheme" },
	filename = { ["yup.lock"] = "yaml" },
})

-- Diagnostics
vim.diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },
	virtual_text = { spacing = 4, prefix = "●", severity = { min = vim.diagnostic.severity.ERROR } },
	-- Show the diagnostic under the cursor after [d / ]d.
	jump = {
		on_jump = function(_, bufnr) vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false }) end,
	},
})
