local M = {
    "nvimtools/none-ls.nvim",
    event = "BufReadPre",
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- mason
        "williamboman/mason.nvim",
        "jay-babu/mason-null-ls.nvim",
    },
}

function M.config()
    -- mason
    require("mason").setup(require("util.mason").mason)
    require("mason-null-ls").setup({
        ensure_installed = require("util.mason").linter,
        automatic_installation = true,
    })

    -- null-ls
    local null_ls = require("null-ls")
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    local formatting = null_ls.builtins.formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    local diagnostics = null_ls.builtins.diagnostics

    -- https://github.com/prettier-solidity/prettier-plugin-solidity
    null_ls.setup({
        debug = false,
        sources = {
            -- Formatting
            formatting.stylua,
            formatting.prettier,
            formatting.black.with({ extra_args = { "--fast" } }),
            --formatting.prettier.with({
            --    extra_filetypes = { "toml" },
            --    extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
            --}),
            --formatting.eslint,
            -- formatting.google_java_format,
            formatting.gofmt,
            formatting.goimports,
            formatting.markdownlint,
            -- Diagnostics
            diagnostics.golangci_lint,
            -- diagnostics.flake8,
            -- diagnostics.markdownlint,
        },
    })
end

return M
