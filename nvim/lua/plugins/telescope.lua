local M = {
  "nvim-telescope/telescope.nvim",
  event = "BufEnter",
  cmd = { "Telescope" },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}


function M.config()
  local actions = require("telescope.actions")
  require("telescope").setup({
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      path_display = { "smart" },
      file_ignore_patterns = { ".git/", "node_modules" },
      mappings = {
        i = {
          ["<ESC>"] = actions.close,
          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,
          ["<C-n>"] = actions.move_selection_next,
          ["<C-p>"] = actions.move_selection_previous,
        },
      },
    },
  })
end

return M
