local M = {
  "smoka7/hop.nvim",
  version = "*",
  event = "VeryLazy",
}

function M.config()
  require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
end

return M
