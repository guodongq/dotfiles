vim.opt.fillchars = {
    foldopen = "",
    foldclose = "",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = " ",
}

vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldcolumn = "0"

if vim.fn.has("nvim-0.8") == 1 then
    vim.opt.backup = true
    vim.opt.cmdheight = 0
    vim.opt.backupdir = vim.fn.stdpath("state") .. "/backup"
end

if vim.g.neovide then
    vim.opt.guifont = { "FiraCode Nerd Font Mono", "h9" }
    vim.g.neovide_scale_factor = 0.3
end

vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- Raise a dialog when an operation has to be confirmed
vim.opt.confirm = true

-- Preserve view while jumping
vim.o.jumpoptions = 'view'

-- Better buffer splitting
vim.o.splitright = true
vim.o.splitbelow = true

-- Remember 50 items in commandline history
vim.o.history = 50

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Makes neovim and host OS clipboard play nicely with each other
vim.o.clipboard = 'unnamedplus'