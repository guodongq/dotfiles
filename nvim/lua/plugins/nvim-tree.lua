return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    -- lazy = false,
		event = "VeryLazy",
    dependencies = {
	    "nvim-tree/nvim-web-devicons",
    },
    keys = {
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files"},
        { "<leader>ft", "<cmd>NvimTreeToggle<cr>", desc = "File tree"},
        { "<leader>fT", "<cmd>NvimTreeFindFile<cr>", desc = "Focus current file in file tree"},
    },
    config = function()
	    local function my_on_attach(bufnr)
		    local api = require("nvim-tree.api")
		    local function opts(desc)
			    return {desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent =true, nowait = true}
		    end
		    -- default mappings 
		    api.config.mappings.default_on_attach(bufnr)
		    -- custom mappings 
		    vim.keymap.set("n", "u", api.tree.change_root_to_parent, opts("Up"))
		    vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
		    vim.keymap.set("n", "C", api.tree.change_root_to_node, opts("CD"))
	    end


	    require("nvim-tree").setup({
		    sort_by = "case_sensitive",
		    view = {
			    width = 30,
		    },
		    renderer = {
			    group_empty = true,
		    },
		    filters = {
			    dotfiles = true,
		    },
		    on_attach = my_on_attach,
	    })
    end,
  }
}
