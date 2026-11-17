-- Location lists, such as the gO outline, open as a right sidebar; q closes list windows.
local root = assert(arg[1], "repository root required")
dofile(root .. "/nvim/lua/autocmds.lua")
vim.o.columns, vim.o.lines = 120, 30

local source = vim.api.nvim_get_current_win()
local items = { { bufnr = vim.api.nvim_get_current_buf(), lnum = 1, text = "outline" } }
vim.fn.setloclist(source, items)
vim.cmd.lopen()
local outline = vim.api.nvim_get_current_win()
assert(vim.fn.win_gettype(outline) == "loclist", "Location list did not open")
local width = vim.api.nvim_win_get_width(outline)
assert(vim.api.nvim_win_get_position(outline)[2] + width == vim.o.columns, "Location list is not on the right")
assert(width == 40, "Unexpected outline width: " .. width)

vim.api.nvim_win_set_width(outline, 50)
vim.fn.setloclist(source, items, "r")
assert(vim.api.nvim_win_get_width(outline) == 50, "Refreshing the list reset its width")

vim.cmd.normal("q")
assert(not vim.api.nvim_win_is_valid(outline), "q did not close the location list")

vim.fn.setqflist(items)
vim.cmd("botright copen")
local quickfix = vim.api.nvim_get_current_win()
assert(vim.api.nvim_win_get_width(quickfix) == vim.o.columns, "Quickfix list should stay at the bottom")
vim.cmd.normal("q")
assert(not vim.api.nvim_win_is_valid(quickfix), "q did not close the quickfix list")
