-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

require("neo-tree").setup({
  window = {
    mappings = {
      ["o"] = "open",
      ["<space>"] = {
          "<leader>",
          nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
      },
    },
  },
})
