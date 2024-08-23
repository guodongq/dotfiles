-- https://github.com/nvim-tree/nvim-tree.lua
return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	keys = {
		{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Nvim: Toggle [E]xplorer" },
	},
	opts = {
		on_attach = function(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree:" .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			-- default mappings
			api.config.mappings.default_on_attach(bufnr)
			-- custom mappings
			vim.keymap.set("n", "u", api.tree.change_root_to_parent, opts("Up"))
			vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
			vim.keymap.set("n", "C", api.tree.change_root_to_node, opts("CD"))
			vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
		end,
		update_focused_file = {
			enable = true,
			update_cwd = true,
		},
		sort = {
			sorter = "case_sensitive",
		},
		view = {
			-- width = 30,
			adaptive_size = true,
			side = "left",
		},
		renderer = {
			group_empty = true,
		},
		diagnostics = {
			enable = true,
			show_on_dirs = false,
		},
		filters = {
			dotfiles = true,
		},
	},
	config = function(_, opts)
		-- disable netrw at the very start of your init.lua
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- optionally enable 24-bit colour
		vim.opt.termguicolors = vim.g.have_nerd_font

		require("nvim-tree").setup(opts)

		vim.cmd([[
                :hi      NvimTreeExecFile    guifg=#ffa0a0
                :hi      NvimTreeSpecialFile guifg=#ff80ff gui=underline
                :hi      NvimTreeSymlink     guifg=Yellow  gui=italic
                :hi link NvimTreeImageFile   Title
            ]])
	end,
}

