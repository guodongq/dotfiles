vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- auto format
vim.g.autoformat = true

-- LazyVim root dir detection
-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

-- Hide deprecation warnings
vim.g.deprecation_warnings = false

-- Set filetype to `bigfile` for files larger than 1.5 MB
-- Only vim syntax will be enabled (with the correct filetype)
-- LSP, treesitter and other ft plugins will be disabled.
-- mini.animate will also be disabled.
vim.g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB

-- Show the current document symbols location from Trouble in lualine
vim.g.trouble_lualine = true

-- Disable builtin provider
vim.g.loaded_perl_provider = 0 -- Disable perl provider
vim.g.loaded_ruby_provider = 0 -- Disable ruby provider
vim.g.loaded_node_provider = 0 -- Disable node provider
vim.g.loaded_php_provider = 0 -- Disable php provider


local default_options = {
    -- generic
    cmdheight = 1, -- more space in the neovim command line for displaying messages
    colorcolumn = "80",
    encoding = "utf-8",
    fileencoding = "utf-8",
    clipboard = "unnamedplus",
    confirm = true,
    mouse = "a",
    number = true,
    showmode = false,
    signcolumn = "yes", -- Always show the signcolumn, otherwise it would shift the text each time
    timeoutlen = 300,

    -- lsp
    completeopt = "menu,menuone,noselect",

    -- editor
    autowrite = true,
    conceallevel = 0, -- so that `` is visible in markdown files
    fillchars = {
        foldopen = "",
        foldclose = "",
        fold = " ",
        foldsep = " ",
        diff = "╱",
        eob = " ",
    },
    foldlevel = 99,
    spelllang = { "en" },
    undofile = true,
    undolevels = 10000,
    updatetime = 200, -- Save swap file and trigger CursorHold
    virtualedit = "block", -- Allow cursor to move where there is no text in visual block mode
    wildmode = "longest:full,full", -- Command-line completion mode
    winminwidth = 5, -- Minimum window width

    -- ui
    cursorline = true,
    formatoptions = "jcroqlnt", -- tcqj
    grepformat = "%f:%l:%c:%m",
    laststatus = 3,
    linebreak = true, -- Wrap lines at convenient points
    -- list = true, -- Show some invisible characters (tabs...
    -- listchars = { tab = "▸ ", trail = "⬝", eol = "¬" },
    pumblend = 10, -- Popup blend
    pumheight = 10, -- Maximum number of entries in a popup
    relativenumber = true,
    scrolloff = 4, -- Lines of context
    shiftround = true, -- Round indent
    sidescrolloff = 8, -- Columns of context
    splitright = true,
    splitbelow = true,
    splitkeep = "screen",
    termguicolors = true,
    wrap = false, -- Disable line wrap

    -- tab
    expandtab = true,
    tabstop = 2,
    softtabstop = 2,
    shiftwidth = 2,

    -- search
    ignorecase = true,
    inccommand = "nosplit", -- preview incremental substitute
    jumpoptions = "view",
    incsearch = true,
    hlsearch = true,
    smartcase = true,
    smartindent = true,
}

for k, v in pairs(default_options) do
    vim.opt[k] = v
end

if vim.fn.has("nvim-0.10") == 1 then
    vim.opt.smoothscroll = true
    --opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
    vim.opt.foldmethod = "expr"
    vim.opt.foldtext = ""
else
    vim.opt.foldmethod = "indent"
    --opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
