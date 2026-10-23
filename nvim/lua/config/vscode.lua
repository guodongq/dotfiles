-- VSCode Neovim (https://github.com/vscode-neovim/vscode-neovim).
-- VSCode provides the UI and language features, so this file only maps keys to
-- VSCode commands, mirroring config/keymaps.lua and the plugin keymaps.
-- The extension already maps gd, gf, gh/K, gH, gO, z= and gc/gcc.
local vscode = require("vscode")
local map = vim.keymap.set

---@param cmd string VSCode command id
local function action(cmd)
	return function() vscode.action(cmd) end
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.clipboard = "unnamedplus"
vim.o.timeoutlen = 300
vim.o.undofile = true

-- Editing
map("n", "0", "^", { desc = "First non-blank character" })
map("n", "<leader>o", "o<Esc>", { desc = "New line below" })
map("n", "<leader>O", "O<Esc>", { desc = "New line above" })
map("n", "<M-j>", "<cmd>move .+1<cr>==", { desc = "Move line down" })
map("n", "<M-k>", "<cmd>move .-2<cr>==", { desc = "Move line up" })
map("x", "<M-j>", ":move '>+1<cr>gv=gv", { desc = "Move selection down" })
map("x", "<M-k>", ":move '<-2<cr>gv=gv", { desc = "Move selection up" })
map("n", "za", action("editor.toggleFold"), { desc = "Toggle fold" })

-- Files and editors
map({ "n", "x" }, "<leader>S", action("workbench.action.files.save"), { desc = "[S]ave file" })
map({ "n", "x" }, "<leader>W", action("workbench.action.files.saveAll"), { desc = "Save all files" })
map("n", "<leader>Q", action("workbench.action.closeWindow"), { desc = "[Q]uit window" })
map("n", "<S-h>", action("workbench.action.previousEditor"), { desc = "Previous editor" })
map("n", "<S-l>", action("workbench.action.nextEditor"), { desc = "Next editor" })
map("n", "<leader>bd", action("workbench.action.closeActiveEditor"), { desc = "[B]uffer [D]elete" })
map("n", "<leader>bo", action("workbench.action.closeOtherEditors"), { desc = "[B]uffer delete [O]thers" })
map("n", "<leader>e", action("workbench.view.explorer"), { desc = "Toggle [E]xplorer" })
map("n", "<leader>E", action("workbench.files.action.showActiveFileInExplorer"), { desc = "Reveal file in [E]xplorer" })

-- Windows (editor groups)
map({ "n", "x" }, "<C-h>", action("workbench.action.focusLeftGroup"), { desc = "Focus left group" })
map({ "n", "x" }, "<C-j>", action("workbench.action.focusBelowGroup"), { desc = "Focus lower group" })
map({ "n", "x" }, "<C-k>", action("workbench.action.focusAboveGroup"), { desc = "Focus upper group" })
map({ "n", "x" }, "<C-l>", action("workbench.action.focusRightGroup"), { desc = "Focus right group" })
map("n", "<leader>ws", action("workbench.action.splitEditorDown"), { desc = "[S]plit window" })
map("n", "<leader>wv", action("workbench.action.splitEditor"), { desc = "Split window [V]ertically" })
map("n", "<leader>wd", action("workbench.action.closeEditorsInGroup"), { desc = "[D]elete window" })

-- Code navigation
map("n", "gD", action("editor.action.revealDeclaration"), { desc = "[G]oto [D]eclaration" })
map("n", "grt", action("editor.action.goToTypeDefinition"), { desc = "[G]oto [T]ype Definition" })
map("n", "gri", action("editor.action.goToImplementation"), { desc = "[G]oto [I]mplementation" })
map("n", "grr", action("editor.action.goToReferences"), { desc = "[G]oto [R]eferences" })
map("n", "grw", action("workbench.action.showAllSymbols"), { desc = "Workspace Symbols" })
map("n", "gK", action("editor.action.triggerParameterHints"), { desc = "Signature Help" })
map("n", "grn", action("editor.action.rename"), { desc = "[R]ename Symbol" })
map({ "n", "x" }, "gra", action("editor.action.quickFix"), { desc = "Code [A]ction" })
map("n", "<leader>cs", action("outline.focus"), { desc = "Code [S]ymbols" })
map("n", "<leader>th", action("editor.action.inlayHints.toggle"), { desc = "[T]oggle Inlay [H]ints" })

-- Diagnostics
map("n", "]d", action("editor.action.marker.next"), { desc = "Next [D]iagnostic" })
map("n", "[d", action("editor.action.marker.prev"), { desc = "Previous [D]iagnostic" })
map("n", "<leader>q", action("workbench.action.problems.focus"), { desc = "Problems [Q]uickfix" })

-- Git hunks (VSCode Git and GitLens)
map("n", "]h", action("workbench.action.editor.nextChange"), { desc = "Next [H]unk" })
map("n", "[h", action("workbench.action.editor.previousChange"), { desc = "Previous [H]unk" })
map({ "n", "x" }, "<leader>hs", action("git.stageSelectedRanges"), { desc = "[H]unk [S]tage" })
map({ "n", "x" }, "<leader>hr", action("git.revertSelectedRanges"), { desc = "[H]unk [R]evert" })
map("n", "<leader>hd", action("git.openChange"), { desc = "[H]unk [D]iff" })
map("n", "<leader>hb", action("gitlens.toggleFileBlame"), { desc = "[H]unk [B]lame (GitLens)" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight yanked text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function() vim.hl.on_yank() end,
})
