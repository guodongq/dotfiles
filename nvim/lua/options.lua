-- utf-8
vim.g.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- highlight the current line
vim.opt.cursorline = true

-- set number lines
vim.opt.number = true
-- vim.opt.relativenumber = true

-- ignore case in search patterns, except smart case
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- set clipboard
vim.opt.clipboard = "unnamedplus"

-- deny to create backup file
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.timeoutlen = 1000

-- force all horizontal splits to go below current window, force all vertical splits to go to the right of current window
vim.opt.splitbelow = true
vim.opt.splitright = true

-- mostly just for cmp
vim.opt.completeopt = {"menu", "menuone", "noselect", "noinsert"}

-- make indenting smarter again
vim.opt.smartindent = true

-- convert tabs to spaces
vim.opt.expandtab = true

-- set term gui colors (most terminals support this)
vim.opt.termguicolors = true
vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications

-- when file changed by other application, load automatically
vim.opt.autoread = true

-- allow the mouse to be used in neovim
vim.opt.mouse = "a"

-- more space in the neovim command line for displaying messages
vim.opt.cmdheight = 1

-- so that `` is visible in markdown files
vim.opt.conceallevel = 0

-- highlight all matches on previous search pattern
vim.opt.hlsearch = true

-- pop up menu height
vim.opt.pumheight = 10

-- we don't need to see things like -- INSERT -- anymore
vim.opt.showmode = false

-- always show tabs
vim.opt.showtabline = 2

-- faster completion（4000ms default）
vim.opt.updatetime = 300

-- >> << the number of spaces inserted for each indentation
vim.opt.shiftwidth = 2

-- insert 2 spaces for a tab
vim.opt.tabstop = 2

-- always show the sign column, otherwise it would shift the text each time
vim.opt.signcolumn = "yes"

-- display lines as one long line
vim.opt.wrap = false

-- hjkl move to keep 8 lines as surround
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- tidy
vim.opt.undofile = true
vim.opt.laststatus = 3
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.numberwidth = 4
vim.opt.fillchars.eob=" "
vim.opt.shortmess:append "c"
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")