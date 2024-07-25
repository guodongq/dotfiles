local M = {
    "folke/todo-comments.nvim",
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
    -- stylua: ignore
    keys = {
        { "<leader>tt", "<cmd>TodoTelescope<cr>", desc = "TODO: [T]oggle [T]odo Comments" },
    },
}

return M
