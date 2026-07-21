local M = {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = function() return vim.fn.executable("make") == 1 end },
		{ "nvim-telescope/telescope-ui-select.nvim" },
	},
	keys = {
		{ "<leader>sf", function() require("telescope.builtin").find_files()  end, desc = "[S]earch [F]iles"    },
		{ "<leader>sg", function() require("telescope.builtin").live_grep()   end, desc = "[S]earch by [G]rep"  },
		{ "<leader>sb", function() require("telescope.builtin").buffers()     end, desc = "[S]earch [B]uffers"  },
		{ "<leader>sh", function() require("telescope.builtin").help_tags()   end, desc = "[S]earch [H]elp"     },
		{ "<leader>sc", function() require("telescope.builtin").commands()    end, desc = "[S]earch [C]ommands" },
	},
}

M.config = function()
	require("telescope").setup({
		extensions = {
			["ui-select"] = { require("telescope.themes").get_dropdown() },
		},
	})
	pcall(require("telescope").load_extension, "fzf")
	pcall(require("telescope").load_extension, "ui-select")
end

return M
