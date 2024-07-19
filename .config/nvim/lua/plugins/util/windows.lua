local M = {
    "0x00-ketsu/maximizer.nvim",
    event = "VeryLazy",
    dependencies = {
        "yorickpeterse/nvim-window",
    },
    keys = {
        { "<leader>wd", "<cmd>wincmd c<cr>", desc = "Close Current Window", mode = "n" },
        { "<leader>wD", "<cmd>wincmd o<cr>", desc = "Close Other Windows", mode = "n" },
        { "<leader>wh", "<cmd>wincmd h<cr>", desc = "Go To The Left Window", mode = "n" },
        { "<leader>wj", "<cmd>wincmd j<cr>", desc = "Go To The Down Window", mode = "n" },
        { "<leader>wk", "<cmd>wincmd k<cr>", desc = "Go To The Up Window", mode = "n" },
        { "<leader>wl", "<cmd>wincmd l<cr>", desc = "Go To The Right Window", mode = "n" },
        { "<leader>ws", "<cmd>sp<cr>", desc = "Split Window", mode = "n" },
        { "<leader>wv", "<cmd>vsp<cr>", desc = "Split Window Vertically", mode = "n" },
        { "<leader>wm", "<cmd>lua require('maximizer').toggle()<cr>", desc = "Maximize Current Window", mode = "n" },
        { "<leader>wc", "<cmd>lua require('nvim-window').pick()<cr>", desc = "Pick A Window", mode = "n" },
    },
}

function M.config()
    -- windows-maximizer
    require("maximizer").setup({})
    -- windows-pick
    require("nvim-window").setup({
        -- The characters available for hinting windows.
        chars = {
            "a",
            "b",
            "c",
            "d",
            "e",
            "f",
            "g",
            "h",
            "i",
            "j",
            "k",
            "l",
            "m",
            "n",
            "o",
            "p",
            "q",
            "r",
            "s",
            "t",
            "u",
            "v",
            "w",
            "x",
            "y",
            "z",
        },

        -- A group to use for overwriting the Normal highlight group in the floating
        -- window. This can be used to change the background color.
        normal_hl = "Normal",

        -- The highlight group to apply to the line that contains the hint characters.
        -- This is used to make them stand out more.
        hint_hl = "Bold",

        -- The border style to use for the floating window.
        border = "single",
    })
end

return M
