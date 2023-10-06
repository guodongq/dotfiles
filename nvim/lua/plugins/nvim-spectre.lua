local M= {
  "nvim-pack/nvim-spectre",
  event = "VeryLazy",
  dependencies = "nvim-lua/plenary.nvim",
}

function M.config()
  require("spectre").setup()
end


return M
