local M = {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
        icons = {
            rules = false, -- rather not use icons
        },
        spec = {
            mode = { "n", "v" },
            { "<leader>;", "<cmd>Alpha<cr>", desc = "Alpha" },
            { "<leader>h", "<cmd>nohlsearch<cr>", desc = "Clear Highlights" },
            { "<leader>q", "<cmd>confirm q<cr>", desc = "Quit" },
            { "<leader>Q", "<cmd>confirm qall<cr>", desc = "Quit All" },

            { "<leader>b", group = "buffer" },
            { "<leader>d", group = "debug" },
            { "<leader>f", group = "file/find" },
            { "<leader>j", group = "jump" },
            { "<leader>l", group = "lsp" },
            { "<leader>s", group = "search" },
            { "<leader>w", group = "windows" },
            { "<leader>x", group = "diagnostics/quickfix" },

            { "g", group = "goto" },
            { "gs", group = "surround" },
            { "z", group = "fold" },
        },
    },
    keys = {
        {
            "<leader>fs",
            "<cmd>w!<cr>",
            desc = "Save file",
        },
        {
            "<leader>ft",
            "<cmd>NvimTreeToggle<cr>",
            desc = "Toggle Explorer",
        },
    },
}

return M
