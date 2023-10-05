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
