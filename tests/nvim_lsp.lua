-- Language servers must start with blink.cmp's completion capabilities.
local root = assert(arg[1], "repository root required")
vim.opt.runtimepath:prepend(assert(arg[2], "installed lazy.nvim path required"))

local function spec(file, name, dir)
	for _, plugin in ipairs(dofile(root .. "/nvim/lua/plugins/" .. file)) do
		if plugin[1] == name then
			plugin.dir = dir
			return plugin
		end
	end
	error(name .. " configuration missing")
end

local blink = spec("editor.lua", "saghen/blink.cmp", assert(arg[3], "installed blink.cmp path required"))
-- Use the Lua matcher so the test never downloads native binaries.
blink.opts = vim.tbl_deep_extend("force", blink.opts, {
	fuzzy = { implementation = "lua", prebuilt_binaries = { download = false } },
})
local lsp = spec("lsp.lua", "neovim/nvim-lspconfig", assert(arg[4], "installed nvim-lspconfig path required"))
-- Keep the real blink.cmp dependency; stub Mason and capture what servers would start with.
lsp.dependencies = vim.tbl_filter(function(dependency) return dependency == "saghen/blink.cmp" end, lsp.dependencies)
package.loaded["mason-lspconfig"] = { setup = function() end }
local capabilities -- false when servers would start without any
vim.lsp.enable = function() capabilities = vim.lsp.config["*"].capabilities or false end

vim.o.loadplugins = true
require("lazy").setup({ blink, lsp }, {
	install = { missing = false },
	rocks = { enabled = false },
	local_spec = false,
	change_detection = { enabled = false },
	readme = { enabled = false },
	lockfile = vim.fn.stdpath("state") .. "/lazy-lock.json",
})
assert(capabilities ~= nil, "LSP servers were not enabled")
assert(
	vim.deep_equal(capabilities, require("blink.cmp").get_lsp_capabilities()),
	"LSP servers start without completion capabilities"
)
io.stdout:write("LSP checks passed\n")
