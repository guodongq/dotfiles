-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

require("neo-tree").setup({
  window = {
    mappings = {
      ["<space>"] = { 
                "toggle_node", 
                nowait = true, -- disable `nowait` if you have existing combos starting with this char that you want to use 
            },
      ["o"] = "open",
    },
  },
})

vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
