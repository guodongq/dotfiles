return {
    -- gruvbox
    {
        "ellisonleao/gruvbox.nvim",
        enabled = true,
        lazy = false,
        priority = 1000,
        init = function()
            vim.opt.background = "dark"
        end,
        config = function()
            vim.cmd.colorscheme("gruvbox")
        end,
    },
    -- tokyonight
    {
        "folke/tokyonight.nvim",
        enabled = false,
        lazy = false,
        priority = 1000,
        opts = { style = "moon" },
        config = function()
            vim.cmd.colorscheme("tokyonight")
        end,
    },
    -- sakura
    {
        "numToStr/Sakura.nvim",
        enabled = false,
        lazy = false,
        priority = 1000,
        config = function()
            require("Sakura").load()
        end,
    },
    -- catppuccin
    {
        "catppuccin/nvim",
        name = "catppuccin",
        enabled = false,
        lazy = false,
        priority = 1000,
        init = function()
            vim.opt.background = "dark"
        end,
        config = function()
            vim.cmd.colorscheme("catppuccin")
        end,
        opts = {
            integrations = {
                aerial = true,
                alpha = true,
                cmp = true,
                dashboard = true,
                flash = true,
                gitsigns = true,
                headlines = true,
                illuminate = true,
                indent_blankline = { enabled = true },
                leap = true,
                lsp_trouble = true,
                mason = true,
                markdown = true,
                mini = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                },
                navic = { enabled = true, custom_bg = "lualine" },
                neotest = true,
                neotree = true,
                noice = true,
                notify = true,
                semantic_tokens = true,
                telescope = true,
                treesitter = true,
                treesitter_context = true,
                which_key = true,
            },
        },
    },
    -- spaceduck
    {
        "spaceduck-theme/nvim",
        name = "spaceduck",
        enabled = false,
        lazy = false,
        priority = 1000,
        init = function()
            vim.opt.background = "dark"
        end,
        config = function()
            vim.cmd.colorscheme("spaceduck")
        end,
    },
}
