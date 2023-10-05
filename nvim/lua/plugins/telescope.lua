return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{"nvim-telescope/telescope-fzf-native.nvim", build="make"},
      "nvim-telescope/telescope-symbols.nvim",
      { "ahmedkhalf/project.nvim", config = function() require("project_nvim").setup() end },
		},
    keys = {
      {"<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in current buffer"},
      {"<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Search files(root dir)"},
      {"<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Search grep"},
      {"<leader>sp", "<cmd>lua require('telescope').extensions.projects.projects{}<cr>", desc = "Search project"},
      {"<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Search recent"},
      {"<leader>st", "<cmd>Telescope<cr>", desc = "Search(Telescope)"},
    },
		config = function()
			require("telescope").setup({
				defaults = {
					prompt_prefix = "   ", -- " ❯ ", 
					initial_mode = "insert",
					sorting_strategy = "ascending",
          layout_strategy = "horizontal",
					mappings = {
						i = {
							["<ESC>"] = require("telescope.actions").close,
							["<C-p>"] = require("telescope.actions").move_selection_previous,
							["<C-k>"] = require("telescope.actions").move_selection_previous,
							["<C-n>"] = require("telescope.actions").move_selection_next,
							["<C-j>"] = require("telescope.actions").move_selection_next,
							["<C-t>"] = require("telescope.actions").select_tab,
							["<C-y>"] = require("telescope.actions").preview_scrolling_up,
							["<C-e>"] = require("telescope.actions").preview_scrolling_down,
						},
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			})

			require("telescope").load_extension("fzf")
			require("telescope").load_extension("projects")
		end,
	}
}
