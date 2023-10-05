return {
  {
    "numToStr/Comment.nvim",
    event = "BufRead",
    config = true,
    keys = {
      {"<leader>cb", "<cmd>lua require('Comment.api').toggle.blockwise.current()<cr>", desc = "comment-or-uncomment-blocks"},
      {"<leader>co", "<cmd>lua require('Comment.api').insert.linewise.below()<cr>", desc = "comment-line-below"},
      {"<leader>c0", "<cmd>lua require('Comment.api').insert.linewise.above()<cr>", desc = "comment-line-above"},
      {"<leader>c/", "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>", desc = "comment-line-above"},
      {"<leader>c$", "<cmd>lua require('Comment.api').insert.linewise.eol()<cr>", desc = "comment-end-of-line"},
      -- visual
      {"<leader>cb", "<esc><cmd>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<cr>", desc = "comment-or-uncomment-blocks", mode = "v"},
      {"<leader>c/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", desc = "comment-or-uncomment-lines", mode = "v"},

    },
  }
}
