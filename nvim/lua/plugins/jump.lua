return {
    { -- Hop is a Neovim plugin to jump to any location in the visible area
        "smoka7/hop.nvim",
        version = "*",
        enabled = true,
        event = "VeryLazy",
        keys = {
            { "<leader>j1", "<cmd>HopChar1<cr>", desc = "[J]ump [1] Character", mode = "n" },
            { "<leader>j2", "<cmd>HopChar2<cr>", desc = "[J]ump [2] Characters", mode = "n" },
            { "<leader>jl", "<cmd>HopLine<cr>", desc = "[J]ump [L]ine", mode = "n" },
            { "<leader>jp", "<cmd>HopPattern<cr>", desc = "[J]ump By [P]attern", mode = "n" },
            { "<leader>jw", "<cmd>HopWord<cr>", desc = "[J]ump To [W]ord", mode = "n" },
        },
        opts = {
            keys = "etovxqpdygfblzhckisuran",
        },
    }
}