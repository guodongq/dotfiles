-- VSCode Neovim configuration
-- Intentionally minimal: VSCode handles UI, plugins, and most commands.

local map = vim.keymap.set

--- Wrap a VSCode command into a callable function
---@param cmd string
---@return function
local function action(cmd)
    return function() vim.fn.VSCodeNotify(cmd) end
end

-- Settings (aligned with main config)
vim.g.mapleader      = " "
vim.g.maplocalleader = " "
vim.o.clipboard  = "unnamedplus"
vim.o.timeoutlen = 300
vim.o.updatetime = 200
vim.o.undofile   = true
vim.o.swapfile   = false

-- Motion
map("n", "0", "^", { desc = "First non-blank char" })

-- Line manipulation: <A-j/k> matches VSCode Alt+Up/Down convention
-- (frees <C-j/k> for window navigation, consistent with main keybind.lua)
map("n", "<A-j>", "<CMD>move .+1<CR>==",  { desc = "Move line down" })
map("n", "<A-k>", "<CMD>move .-2<CR>==",  { desc = "Move line up" })
map("x", "<A-j>", ":move '>+1<CR>gv=gv", { desc = "Move selection down" })
map("x", "<A-k>", ":move '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Blank lines without entering insert mode
map("n", "<leader>o", "o<ESC>", { desc = "New line below" })
map("n", "<leader>O", "O<ESC>", { desc = "New line above" })

-- File operations (aligned with which-key spec: <leader>S = save, <leader>Q = quit)
map({ "n", "x" }, "<leader>S", action("workbench.action.files.save"),    { desc = "[S]ave File" })
map({ "n", "x" }, "<leader>W", action("workbench.action.files.saveAll"), { desc = "Save [A]ll Files" })
map("n",          "<leader>Q", action("workbench.action.closeWindow"),   { desc = "[Q]uit Window" })

-- Editor/buffer navigation (aligned with main config: <S-h>/<S-l> and <leader>b*)
map("n", "<S-h>",      action("workbench.action.previousEditor"),    { desc = "Prev Editor" })
map("n", "<S-l>",      action("workbench.action.nextEditor"),        { desc = "Next Editor" })
map("n", "<leader>bd", action("workbench.action.closeActiveEditor"), { desc = "[B]uffer [D]elete" })
map("n", "<leader>e",  action("workbench.view.explorer"),            { desc = "Toggle [E]xplorer" })

-- Window/split navigation (aligned with main keybind.lua: <C-h/j/k/l>)
map({ "n", "x" }, "<C-h>", action("workbench.action.focusLeftGroup"),     { desc = "Focus Left" })
map({ "n", "x" }, "<C-j>", action("workbench.action.focusBelowGroup"),    { desc = "Focus Below" })
map({ "n", "x" }, "<C-k>", action("workbench.action.focusAboveGroup"),    { desc = "Focus Above" })
map({ "n", "x" }, "<C-l>", action("workbench.action.focusRightGroup"),    { desc = "Focus Right" })
map("n", "<leader>wv",     action("workbench.action.splitEditor"),         { desc = "Split [W]indow [V]ertical" })
map("n", "<leader>ws",     action("workbench.action.splitEditorDown"),     { desc = "[S]plit [W]indow Horizontal" })
map("n", "<leader>wd",     action("workbench.action.closeEditorsInGroup"), { desc = "[D]elete [W]indow Group" })

-- Folds
map("n", "za", action("editor.toggleFold"), { desc = "Toggle Fold" })

-- Commenting (VSCode Neovim built-in)
map("n",               "gcc", "<Plug>VSCodeCommentaryLine")
map({ "n", "x", "o" }, "gc",  "<Plug>VSCodeCommentary")

-- ─── LSP / Code navigation ──────────────────────────────────────────────────
-- Aligned with main config lsp/lsp.lua keybindings
map("n", "gd",  action("editor.action.revealDefinition"),          { desc = "[G]oto [D]efinition" })
map("n", "gD",  action("editor.action.revealDeclaration"),         { desc = "[G]oto [D]eclaration" })
map("n", "grt", action("editor.action.goToTypeDefinition"),        { desc = "[G]oto [T]ype Definition" })
map("n", "gri", action("editor.action.goToImplementation"),        { desc = "[G]oto [I]mplementation" })
map("n", "grr", action("editor.action.goToReferences"),            { desc = "[G]oto [R]eferences" })
map("n", "grd", action("workbench.action.gotoSymbol"),             { desc = "Document Symbols" })
map("n", "grw", action("workbench.action.showAllSymbols"),         { desc = "Workspace Symbols" })
map("n", "K",   action("editor.action.showHover"),                 { desc = "Hover Documentation" })
map("n", "gK",  action("editor.action.triggerParameterHints"),     { desc = "Signature Help" })
map("n", "grn", action("editor.action.rename"),                    { desc = "[R]ename Symbol" })
map({ "n", "x" }, "gra", action("editor.action.quickFix"),                { desc = "Code [A]ction" })
map("n",          "gro", action("outline.focus"),                           { desc = "Code [O]utline" })
map("n",          "<leader>th", action("editor.action.inlayHints.toggle"), { desc = "[T]oggle Inlay [H]ints" })

-- ─── Diagnostics ─────────────────────────────────────────────────────────────
-- Aligned with main config: ]d/[d and <leader>q
map("n", "]d",        action("editor.action.marker.next"),       { desc = "Next [D]iagnostic" })
map("n", "[d",        action("editor.action.marker.prev"),       { desc = "Prev [D]iagnostic" })
map("n", "<leader>q", action("workbench.action.problems.focus"), { desc = "Problems [Q]uickfix" })

-- ─── Git hunks ────────────────────────────────────────────────────────────────
-- Aligned with main config editor/gitsigns.lua keybindings
map("n", "]h",         action("workbench.action.editor.nextChange"),     { desc = "Next [H]unk" })
map("n", "[h",         action("workbench.action.editor.previousChange"), { desc = "Prev [H]unk" })
map("n", "<leader>hs", action("git.stageSelectedRanges"),                { desc = "[H]unk [S]tage" })
map("n", "<leader>hr", action("git.revertSelectedRanges"),               { desc = "[H]unk [R]evert" })
map("v", "<leader>hs", action("git.stageSelectedRanges"),                { desc = "[H]unk [S]tage" })
map("v", "<leader>hr", action("git.revertSelectedRanges"),               { desc = "[H]unk [R]evert" })
map("n", "<leader>hd", action("git.openChange"),                         { desc = "[H]unk [D]iff" })
map("n", "<leader>hb", action("gitlens.toggleFileBlame"),                { desc = "[H]unk [B]lame (GitLens)" })

-- Yank highlight (modern API, aligned with main autocmd.lua)
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("vscode-highlight-yank", { clear = true }),
    callback = function() vim.hl.on_yank() end,
})
