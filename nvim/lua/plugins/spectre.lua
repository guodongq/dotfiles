return {
    { -- nvim-spectre is a Neovim plugin to replace files
        "nvim-pack/nvim-spectre",
        build = false,
        cmd = "Spectre",
        keys = {
            { "<leader>rN", '<cmd>lua require("spectre").open()<cr>', desc = "Spectre: [R]e[n]ame" },
        },
        opts = { open_cmd = "noswapfile vnew" },
        -- stylua: ignore
    }
}