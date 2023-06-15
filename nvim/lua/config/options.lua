local g = vim.g
local o = vim.o

-- cmd('syntax on')
-- vim.api.nvim_command('filetype plugin indent on')

o.termguicolors = true
-- o.background = 'dark'

-- Do not save when switching buffers
-- o.hidden = true

-- Decrease update time
o.timeoutlen = 500
o.updatetime = 200

-- Number of screen lines to keep above and below the cursor
o.scrolloff = 8

-- Better editor UI
o.number = true
o.numberwidth = 5
o.relativenumber = true
o.signcolumn = 'yes:2'
o.cursorline = true

-- Better editing experience
o.expandtab = true
-- o.smarttab = true
o.cindent = true
-- o.autoindent = true
o.wrap = true
o.textwidth = 300
o.tabstop = 2
o.shiftwidth = 0
o.softtabstop = -1 -- If negative, shiftwidth value is used
o.list = true
o.listchars = 'trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂'
-- o.listchars = 'eol:¬,space:·,lead: ,trail:·,nbsp:◇,tab:→-,extends:▸,precedes:◂,multispace:···⬝,leadmultispace:│   ,'
-- o.formatoptions = 'qrn1'

-- Makes neovim and host OS clipboard play nicely with each other
o.clipboard = 'unnamedplus'

-- Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true

-- Undo and backup options
o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = false
-- o.backupdir = '/tmp/'
-- o.directory = '/tmp/'
-- o.undodir = '/tmp/'

-- Remember 50 items in commandline history
o.history = 50

-- Better buffer splitting
o.splitright = true
o.splitbelow = true

-- Preserve view while jumping
o.jumpoptions = 'view'

-- Stable buffer content on window open/close events.
o.splitkeep = 'screen'

-- Improve diff
vim.opt.diffopt:append('linematch:60')

-- WARN: this won't update the search count after pressing `n` or `N`
-- When running macros and regexes on a large file, lazy redraw tells neovim/vim not to draw the screen
-- o.lazyredraw = true

-- Better folds (don't fold by default)
-- o.foldmethod = 'indent'
-- o.foldlevelstart = 99
-- o.foldnestmax = 3
-- o.foldminlines = 1

-- Map <leader> to space
g.mapleader = ' '
g.maplocalleader = ' '



-- Leader/local leader
vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[ ]]

vim.o.backspace = "indent,eol,start"
vim.opt.nrformats:remove({ "octal" })
vim.o.listchars = "tab:→ ,eol:↵,trail:·,extends:↷,precedes:↶"
vim.o.fillchars = "vert:│,fold:·"
vim.o.laststatus = 2

vim.o.showcmd = false

vim.o.autoindent = true

vim.o.linebreak = true

vim.o.wildmenu = true

vim.o.linebreak = true

vim.o.number = true

vim.o.autoread = true

vim.o.backup = true

vim.o.undofile = true

vim.o.undolevels = 1000

vim.o.writebackup = false

vim.o.matchtime = 0

vim.o.ruler = false

vim.o.showmatch = true

vim.o.showmode = true

vim.o.completeopt = "menu,menuone,longest"

vim.o.complete = ".,w,b,u,t"

vim.o.pumheight = 15

vim.o.scrolloff = 1
vim.o.sidescrolloff = 5
vim.opt.display = vim.opt.display + { "lastline" }
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.wildignorecase = true
vim.o.mouse = "nv"
vim.o.hidden = true
vim.o.ttimeout = true
vim.o.ttimeoutlen = 50

vim.opt.shortmess:append("s")
-- Do not wrap lone lines
vim.o.wrap = false

vim.opt.confirm = true -- Raise a dialog when an operation has to be confirmed
