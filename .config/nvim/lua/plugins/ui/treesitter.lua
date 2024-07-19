local M = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "HiPhish/rainbow-delimiters.nvim",
    }
}

M.opts = {
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
    autopairs = {
        enable = true,
    },
    sync_install = true,
    ensure_installed = {
        "c",
        "go",
        "json",
        "markdown",
        "python",
        "toml",
        "yaml",
        "vimdoc",
    },
}

function M.config(_, opts)
    require("nvim-treesitter.configs").setup(opts)
    vim.opt.foldmethod = "expr"
    vim.opt.foldlevel = 99
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

    local rainbow_delimiters = require 'rainbow-delimiters'
    require('rainbow-delimiters.setup').setup {
        strategy = {
            [''] = rainbow_delimiters.strategy['global'],
            vim = rainbow_delimiters.strategy['local'],
        },
        query = {
            [''] = 'rainbow-delimiters',
            lua = 'rainbow-blocks',
        },
        priority = {
            [''] = 110,
            lua = 210,
        },
        highlight = {
            'RainbowDelimiterRed',
            'RainbowDelimiterYellow',
            'RainbowDelimiterBlue',
            'RainbowDelimiterOrange',
            'RainbowDelimiterGreen',
            'RainbowDelimiterViolet',
            'RainbowDelimiterCyan',
        },
    }
end

return M
