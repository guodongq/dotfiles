return {
  {
    "smoka7/hop.nvim",
    version = "*",
    opts = {},
    keys = {
      { "<leader>j1", "<cmd>HopChar1<cr>", desc = "jump-or-select-to-a-character" },
      { "<leader>j2", "<cmd>HopChar2<cr>", desc = "jump-to-suite-of-two-characters" },
      { "<leader>jl", "<cmd>HopLine<cr>", desc = "jump-or-select-to-a-line" },
      { "<leader>jp", "<cmd>HopPattern<cr>", desc = "jump-or-select-to-a-pattern" },
      { "<leader>jw", "<cmd>HopWord<cr>", desc = "jump-to-a-word" },
    },
  }
}
