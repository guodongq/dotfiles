local M = {
    "nvimtools/none-ls.nvim",
    event = "BufReadPre",
    enabled = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- mason
        "williamboman/mason.nvim",
        "jay-babu/mason-null-ls.nvim",
    },
}

function M.config()
    -- mason
    require("mason").setup()
    require("mason-null-ls").setup({
        ensure_installed = {
            -- "cmakelang",
            -- "gitlint",
            "goimports",
            --"golangci-lint",
            -- "jsonlint",
            "markdownlint",
            -- "protolint",
            "pylint",
            -- "shellcheck",
            -- "yamllint",
        },
        automatic_installation = true,
    })

    -- null-ls
    local nls = require("null-ls")
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    local formatting = nls.builtins.formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    -- local diagnostics = nls.builtins.diagnostics
    -- local codeactions = nls.builtins.code_actions

    -- https://github.com/prettier-solidity/prettier-plugin-solidity
    nls.setup({
        debug = false,
        sources = {
            -- CodeActions
            -- codeactions.shellcheck,

            -- Formatting
            formatting.stylua,
            formatting.prettier,
            --formatting.black.with({ extra_args = { "--fast" } }),
            --formatting.prettier.with({
            --    extra_filetypes = { "toml" },
            --    extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
            --}),
            --formatting.eslint,
            -- formatting.google_java_format,
            formatting.gofmt,
            formatting.goimports,
            formatting.markdownlint,
            formatting.mdformat,

            -- Diagnostics
            -- diagnostics.shellcheck,
            --diagnostics.golangci_lint,
            -- diagnostics.flake8,
            -- diagnostics.markdownlint,
        },
    })
end

return M
