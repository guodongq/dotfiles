-- VSCode Neovim (https://github.com/vscode-neovim/vscode-neovim): the same keys as
-- the terminal config, mapped to VSCode commands. The extension already maps gd, gf,
-- gh/K, gH, gO, z= and gc/gcc.
local vscode = require("vscode")
local map = vim.keymap.set

local function action(cmd)
	return function() vscode.action(cmd) end
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.clipboard = "unnamedplus"
vim.o.timeoutlen = 300
vim.o.undofile = true

-- Folding
map("n", "za", action("editor.toggleFold"), { desc = "Toggle fold" })

-- Files and editors
map("n", "<S-h>", action("workbench.action.previousEditor"), { desc = "Previous editor" })
map("n", "<S-l>", action("workbench.action.nextEditor"), { desc = "Next editor" })
map("n", "<leader>bd", action("workbench.action.closeActiveEditor"), { desc = "[B]uffer [D]elete" })
map("n", "<leader>e", action("workbench.view.explorer"), { desc = "Toggle [E]xplorer" })

-- Windows (editor groups)
map({ "n", "x" }, "<C-h>", action("workbench.action.focusLeftGroup"), { desc = "Focus left group" })
map({ "n", "x" }, "<C-j>", action("workbench.action.focusBelowGroup"), { desc = "Focus lower group" })
map({ "n", "x" }, "<C-k>", action("workbench.action.focusAboveGroup"), { desc = "Focus upper group" })
map({ "n", "x" }, "<C-l>", action("workbench.action.focusRightGroup"), { desc = "Focus right group" })

-- Code navigation
map("n", "gD", action("editor.action.revealDeclaration"), { desc = "[G]oto [D]eclaration" })
map("n", "grt", action("editor.action.goToTypeDefinition"), { desc = "[G]oto [T]ype Definition" })
map("n", "gri", action("editor.action.goToImplementation"), { desc = "[G]oto [I]mplementation" })
map("n", "grr", action("editor.action.goToReferences"), { desc = "[G]oto [R]eferences" })
map("n", "grw", action("workbench.action.showAllSymbols"), { desc = "Workspace Symbols" })
map("n", "gK", action("editor.action.triggerParameterHints"), { desc = "Signature Help" })
map("n", "grn", action("editor.action.rename"), { desc = "[R]ename Symbol" })
map({ "n", "x" }, "gra", action("editor.action.quickFix"), { desc = "Code [A]ction" })

-- Diagnostics
map("n", "]d", action("editor.action.marker.next"), { desc = "Next [D]iagnostic" })
map("n", "[d", action("editor.action.marker.prev"), { desc = "Previous [D]iagnostic" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight yanked text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function() vim.hl.on_yank() end,
})
