local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "BufReadPost",
  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = "VeryLazy",
    },
  },
}

function M.config()
  local treesitter = require("nvim-treesitter")
  local configs = require("nvim-treesitter.configs")

  configs.setup({
    ensure_installed = {
      "c",
      "lua",
      "go",
      "markdown",
      "markdown_inline",
      "bash",
      "json",
    },
    ignore_install = { "" },
    sync_install = false,

    highlight = {
      enable = true, -- false will disable the whole extension
      disable = { "css" }, -- list of language that will be disabled
    },

    autopairs = {
      enable = true,
    },

    indent = {
      enable = true,
      disable = { "python", "css" },
    },

    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
  })

  -- enable folding
  vim.wo.foldmethod = "expr"
  vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
  -- default disable folding
  -- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
  vim.wo.foldlevel = 99
end

return M
