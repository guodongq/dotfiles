local M = {
	"nvim-lualine/lualine.nvim",
	enabled = false,
	event = "VeryLazy",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	init = function()
		vim.g.lualine_laststatus = vim.o.laststatus
		if vim.fn.argc(-1) > 0 then
			-- set an empty statusline till lualine loads
			vim.o.statusline = " "
		else
			-- hide the statusline on the starter page
			vim.o.laststatus = 0
		end
	end,
}

local function search_result()
	if vim.v.hlsearch == 0 then
		return ""
	end
	local last_search = vim.fn.getreg("/")
	if not last_search or last_search == "" then
		return ""
	end
	local searchcount = vim.fn.searchcount({ maxcount = 9999 })
	return last_search .. "(" .. searchcount.current .. "/" .. searchcount.total .. ")"
end

local function modified()
	if vim.bo.modified then
		return "+"
	elseif vim.bo.modifiable == false or vim.bo.readonly == true then
		return "-"
	end
	return ""
end

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 60
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

M.opts = {
	options = {
		icons_enabled = true,
		theme = "auto", --auto
		-- component_separators = { left = "", right = "" },
		-- section_separators = { left = "", right = "" },
		globalstatus = vim.o.laststatus == 3,
		disabled_filetypes = { statusline = { "alpha", "dashboard", "starter" } },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			{ "branch" },
			{
				"diff",
				cond = conditions.hide_in_width,
			},
		},
		lualine_c = {
			{
				function()
					local msg = "No Active Lsp"
					local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
					local clients = vim.lsp.get_active_clients()
					if next(clients) == nil then
						return msg
					end
					for _, client in ipairs(clients) do
						local filetypes = client.config.filetypes
						if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
							return client.name
						end
					end
					return msg
				end,
				icon = " LSP:",
				color = { fg = "#ffffff", gui = "bold" },
			},
		},
		lualine_x = {
			{
				"%w",
				cond = function()
					return vim.wo.previewwindow
				end,
			},
			{
				"%r",
				cond = function()
					return vim.bo.readonly
				end,
			},
			{
				"%q",
				cond = function()
					return vim.bo.buftype == "quickfix"
				end,
			},
			{ search_result, "filetype" },
			{ "diagnostics" },
		},
		lualine_y = {
			{ modified },
			{ "filetype" },
			{ "encoding" },
			{ "fileformat" },
		},
		lualine_z = {
			{ "progress", separator = " ", padding = { left = 1, right = 0 } },
			{ "location", padding = { left = 0, right = 1 } },
			{
				function()
					return " " .. os.date("%R")
				end,
			},
		},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {
		"nvim-tree",
		"toggleterm",
		"nvim-dap-ui",
		"quickfix",
		"symbols-outline",
	},
}

return M
