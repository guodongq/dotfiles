local M = {}

M.g = {
  mapleader = " ",
  maplocalleader = " ",
  -- Fix markdown indentation settings
  markdown_recommended_style = 0,
  -- Disable various builtin plugins in Vim that bog down speed
  loaded_python3_provider = 1,
  loaded_ruby_provider = 1,
  loaded_perl_provider = 1,
  loaded_node_provider = 1,
  loaded_matchparen = 1,
  loaded_matchit = 1,
  loaded_logiPat = 1,
  loaded_rrhelper = 1,
  loaded_tarPlugin = 1,
  loaded_gzip = 1,
  loaded_zipPlugin = 1,
  loaded_2html_plugin = 1,
  loaded_shada_plugin = 1,
  loaded_spellfile_plugin = 1,
  loaded_netrw = 1,
  loaded_netrwPlugin = 1,
  loaded_tutor_mode_plugin = 1,
  loaded_remote_plugins = 1,
}

M.opt = {
  autowrite = true,-- Enable auto write
  clipboard = "unnamedplus", -- Sync with system clipboard
  completeopt = "menu,menuone,noselect",
  conceallevel = 0, -- Hide * markup for bold and italic
  confirm = true, -- Confirm to save changes before exiting modified buffer
  cursorline = true, -- Enable highlighting of the current line
  expandtab = true, -- Use spaces instead of tabs
  formatoptions = "jcroqlnt", -- tcqj
  grepformat = "%f:%l:%c:%m",
  grepprg = "rg --vimgrep",
  ignorecase = true, -- Ignore case
  inccommand = "nosplit", -- preview incremental substitute
  laststatus = 0,
  list = true, -- Show some invisible characters (tabs...
  mouse = "a", -- Enable mouse mode
  number = true, -- Print line number
  pumblend = 10, -- Popup blend
  pumheight = 10, -- Maximum number of entries in a popup
  relativenumber = true, -- Relative line numbers
  scrolloff = 4, -- Lines of context
  sessionoptions = { "buffers", "curdir", "tabpages", "winsize" },
  shiftround = true, -- Round indent
  shiftwidth = 2, -- Size of an indent
  --shortmess:append({ W = true, I = true, c = true }),
  showmode = false, -- Dont show mode since we have a statusline
  sidescrolloff = 8, -- Columns of context
  signcolumn = "yes", -- Always show the signcolumn, otherwise it would shift the text each time
  smartcase = true, -- Don't ignore case with capitals
  smartindent = true,-- Insert indents automatically
  spelllang = { "en" },
  splitbelow = true, -- Put new windows below current
  splitright = true, -- Put new windows right of current
  tabstop = 2, -- Number of spaces tabs count for
  termguicolors = true, -- True color support
  timeoutlen = 300,
  undofile = true,
  undolevels = 10000,
  updatetime = 200, -- Save swap file and trigger CursorHold
  wildmode = "longest:full,full", -- Command-line completion mode
  winminwidth = 5, -- Minimum window width
  wrap = false, -- Disable line wrap
}

if vim.fn.has("nvim-0.9.0") == 1 then
  vim.opt.splitkeep = "screen"
  vim.opt.shortmess:append({ C = true })
end

for prefix, tbl in pairs(M) do
    for key, value in pairs(tbl) do
        vim[prefix][key] = value
    end
end

return M
