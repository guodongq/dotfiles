-- Notebook preview: one JupyterLab per project, opened at each notebook's URL.
-- The stub jupyter from test_dotfiles.py logs its URL in two parts, or exits in */broken.
local root = assert(arg[1], "repository root required")
package.path = root .. "/nvim/lua/?.lua;" .. package.path
local preview = require("preview")

local home = assert(vim.env.HOME)
for _, dir in ipairs({ "project/.git", "project/sub dir", "broken" }) do
	vim.fn.mkdir(home .. "/" .. dir, "p")
end
for _, file in ipairs({ "project/first.ipynb", "project/sub dir/second #1.ipynb", "broken/third.ipynb" }) do
	vim.fn.writefile({ "{}" }, home .. "/" .. file)
end
local function open(file)
	vim.cmd.edit(vim.fn.fnameescape(home .. "/" .. file))
	preview.open()
end

local opened, warnings = {}, {}
vim.ui.open = function(url) table.insert(opened, url) end
vim.notify = function(message) table.insert(warnings, message) end
local base = "http://127.0.0.1:9999/lab/tree/"

open("project/first.ipynb")
open("project/sub dir/second #1.ipynb") -- while JupyterLab starts: show the latest notebook
assert(vim.wait(5000, function() return #opened > 0 end), "No preview opened: " .. vim.inspect(warnings))
open("project/first.ipynb") -- reuse the running server
assert(
	vim.deep_equal(opened, { base .. "sub%20dir/second%20%231.ipynb?token=abc", base .. "first.ipynb?token=abc" }),
	vim.inspect(opened)
)

open("broken/third.ipynb")
assert(vim.wait(5000, function() return #warnings > 0 end), "JupyterLab failure was not reported")
assert(warnings[1]:find("code 3", 1, true), warnings[1])
assert(#vim.fn.readfile(home .. "/jupyter-starts") == 2, "Expected one JupyterLab per project")
io.stdout:write("Preview checks passed\n")
