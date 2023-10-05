return {
  {
    "yorickpeterse/nvim-window",
    config = true,
    keys = {
      { "<leader>wc", "<cmd>lua require('nvim-window').pick()<cr>", desc = "Choose a window"},
    },
  }
}
