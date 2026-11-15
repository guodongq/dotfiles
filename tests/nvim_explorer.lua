local root = assert(arg[1], "repository root required")
local snacks_path = assert(arg[2], "installed Snacks path required")
vim.opt.runtimepath:prepend(snacks_path)

local options
for _, spec in ipairs(dofile(root .. "/nvim/lua/plugins/ui.lua")) do
	if spec[1] == "folke/snacks.nvim" then
		options = spec.opts
		break
	end
end
assert(options, "Snacks configuration missing")

Snacks = require("snacks")
Snacks.setup(options)
local keys = Snacks.picker.config.get({ source = "explorer", cwd = root }).win.list.keys
for _, mapping in ipairs({
	{ "o", "confirm" },
	{ "u", "explorer_up" },
	{ "C", "explorer_focus" },
	{ "R", "explorer_update" },
}) do
	local key, action = mapping[1], mapping[2]
	assert(keys[key] == action, key .. ": expected " .. action .. ", got " .. tostring(keys[key]))
end
