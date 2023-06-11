vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- cmd('syntax on')
-- vim.api.nvim_command('filetype plugin indent on')

vim.opt.termguicolors = true
-- vim.opt.background = 'dark'

-- Do not save when swithing buffers
-- vim.opt.hidden = true

-- Decrease update time
vim.opt.timeoutlen = 500
vim.opt.updatetime = 200

-- Number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 8

-- Better editor UI
vim.opt.number = true
vim.opt.numberwidth = 5
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes:2'
vim.opt.cursorline = true

-- Better editing experience
vim.opt.expandtab = true
-- vim.opt.smarttab = true
vim.opt.cindent = true
-- vim.opt.autoindent = true
vim.opt.wrap = true
vim.opt.textwidth = 300
vim.opt.tabstop = 2
vim.opt.shiftwidth = 0
vim.opt.softtabstop = -1 -- If negative, shiftwidth value is used
vim.opt.list = true
vim.opt.listchars = 'trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂'
-- vim.opt.listchars = 'eol:¬,space:·,lead: ,trail:·,nbsp:◇,tab:→-,extends:▸,precedes:◂,multispace:···⬝,leadmultispace:│   ,'
-- vim.opt.formatoptions = 'qrn1'

-- Makes neovim and host OS clipboard play nicely with each other
vim.opt.clipboard = 'unnamedplus'

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Undo and backup options
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true
vim.opt.swapfile = false
-- vim.opt.backupdir = '/tmp/'
-- vim.opt.directory = '/tmp/'
-- vim.opt.undodir = '/tmp/'

-- Remember 50 items in commandline history
vim.opt.history = 50

-- Better buffer splitting
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preserve view while jumping
vim.opt.jumpoptions = 'view'

-- Stable buffer content on window open/close events.
vim.opt.splitkeep = 'screen'

-- Improve diff
vim.opt.diffopt:append('linematch:60')

-- WARN: this won't update the search count after pressing `n` or `N`
-- When running macros and regexes on a large file, lazy redraw tells neovim/vim not to draw the screen
-- vim.opt.lazyredraw = true

-- Better folds (don't fold by default)
-- vim.opt.foldmethod = 'indent'
-- vim.opt.foldlevelstart = 99
-- vim.opt.foldnestmax = 3
-- vim.opt.foldminlines = 1

-- vim.opt.mouse = 'a' -- Enable mouse for all modes
-- vim.opt.mousefocus = true
-- vim.opt.mousemodel = 'extend'

vim.opt.confirm = true -- Raise a dialog when an operation has to be confirmed
