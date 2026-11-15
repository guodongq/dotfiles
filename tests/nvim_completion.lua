local root = assert(arg[1], "repository root required")
vim.opt.runtimepath:prepend(assert(arg[2], "installed lazy.nvim path required"))
local blink_path = assert(arg[3], "installed blink.cmp path required")
local event = assert(arg[4], "load event required")

local spec
for _, plugin in ipairs(dofile(root .. "/nvim/lua/plugins/editor.lua")) do
	if plugin[1] == "saghen/blink.cmp" then
		spec = plugin
		break
	end
end
assert(spec, "Completion configuration missing")
spec.dir = blink_path
-- Use the Lua matcher so the test never downloads native binaries.
spec.opts = vim.tbl_deep_extend("force", spec.opts, {
	fuzzy = { implementation = "lua", prebuilt_binaries = { download = false } },
})
vim.o.loadplugins = true
require("lazy").setup({ spec }, {
	install = { missing = false },
	rocks = { enabled = false },
	local_spec = false,
	change_detection = { enabled = false },
	readme = { enabled = false },
	lockfile = vim.fn.stdpath("state") .. "/lazy-lock.json",
})
assert(not package.loaded["blink.cmp"], "Completion should load on demand")
vim.api.nvim_exec_autocmds(event, {})
assert(
	vim.wait(1000, function() return package.loaded["blink.cmp.completion"] ~= nil end),
	event .. " did not load completion"
)
vim.api.nvim_exec_autocmds("InsertEnter", {})

local cmp = require("blink.cmp")
local tab = assert(vim.fn.maparg("<Tab>", "i", false, true).callback, "Tab mapping missing")
local enter = assert(vim.fn.maparg("<CR>", "i", false, true).callback, "Enter mapping missing")
local ai_available, ai_calls = false, 0
-- Stub only AI availability; completion and snippet dispatch use the real plugins.
package.loaded["sidekick"] = {
	nes_jump_or_apply = function()
		ai_calls = ai_calls + 1
		return ai_available
	end,
}

assert(tab() == "\t", "Tab should retain its normal behavior without a snippet or AI edit")
ai_available = true
assert(tab() == nil, "An AI edit should consume Tab")
assert(ai_calls == 2, "Tab should check AI only after snippets")

vim.snippet.expand("${1:first} ${2:second}$0")
local before = vim.api.nvim_win_get_cursor(0)
assert(tab() == nil, "An active snippet should consume Tab")
assert(ai_calls == 2, "Snippet navigation must take priority over AI")
assert(
	vim.wait(1000, function() return not vim.deep_equal(before, vim.api.nvim_win_get_cursor(0)) end),
	"Tab did not jump to the next snippet field"
)
vim.snippet.stop()
vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "nx", false)

assert(enter() == "\r", "Enter should retain its normal behavior when completion is hidden")
local candidate = "dotfilesCompletionCandidate"
local prefix = "dotfilesCompletionC"
vim.o.virtualedit = "onemore"
vim.api.nvim_buf_set_lines(0, 0, -1, false, { candidate, prefix })
vim.api.nvim_win_set_cursor(0, { 2, #prefix })
-- Check acceptance in Insert mode, then return to Normal mode to report errors.
local accepted, failure
vim.api.nvim_create_autocmd("InsertEnter", {
	once = true,
	callback = function()
		vim.schedule(function()
			accepted, failure = pcall(function()
				assert(vim.api.nvim_get_mode().mode == "i", "Completion acceptance requires insert mode")
				cmp.show({ providers = { "buffer" } })
				assert(vim.wait(1000, cmp.is_visible), "Buffer completion menu did not appear")
				assert(enter() == nil, "Enter should consume a selected completion")
				assert(
					vim.wait(1000, function() return vim.api.nvim_buf_get_lines(0, 1, 2, false)[1] == candidate end),
					"Enter did not insert the selected completion"
				)
			end)
			vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "n", false)
		end)
	end,
})
vim.api.nvim_feedkeys("i", "nx!", false)
assert(accepted, failure or "Insert-mode checks did not run")
io.stdout:write("Completion checks passed\n")
