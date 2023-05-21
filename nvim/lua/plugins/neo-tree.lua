-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

require("neo-tree").setup({
  follow_current_file = true, -- This will find and focus the file in the active buffer every
  window = {
    mappings = {
      ["o"] = "open",
			["<space>"] = {
                "toggle_node",
                nowait = true, -- disable `nowait` if you have existing combos starting with this char that you want to use
            },
    },
  },
})

vim.cmd([[nnoremap \ :Neotree toggle reveal<cr>]])
