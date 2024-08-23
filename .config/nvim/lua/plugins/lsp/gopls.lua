-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/gopls.lua
local util = require("lspconfig.util")
local async = require("lspconfig.async")
local mod_cache = nil

return {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = function(fname)
		-- see: https://github.com/neovim/nvim-lspconfig/issues/804
		if not mod_cache then
			local result = async.run_command({ "go", "env", "GOMODCACHE" })
			if result and result[1] then
				mod_cache = vim.trim(result[1])
			end
		end
		if fname:sub(1, #mod_cache) == mod_cache then
			local clients = util.get_lsp_clients({ name = "gopls" })
			if #clients > 0 then
				return clients[#clients].config.root_dir
			end
		end
		return util.root_pattern("go.work", "go.mod", ".git")(fname)
	end,
	single_file_support = true,
	settings = {
		gopls = {
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			gofumpt = true,
		},
	},
}
