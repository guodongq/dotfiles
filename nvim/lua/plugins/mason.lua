local M = {
  "williamboman/mason.nvim",
  cmd = "Mason",
  event = "BufReadPre",
  dependencies = {
    -- lsp
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    -- null-ls
    "jay-babu/mason-null-ls.nvim",
    -- dap
    "jay-babu/mason-nvim-dap.nvim"
  }
}

local settings = {
  ui = {
    border = "none",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

function M.config()
  require("mason").setup(settings)
  -- lsp
  require("mason-lspconfig").setup({
    ensure_installed = require("utils").servers,
    automatic_installation = true,
  })
  -- null-ls
  require("mason-null-ls").setup({
    ensure_installed = require("utils").nservers,
    automatic_installation = true,
  })
  -- dap
  require("mason-nvim-dap").setup({
    ensure_installed = require("utils").dservers,
    automatic_installation = true,
  })
end

return M
