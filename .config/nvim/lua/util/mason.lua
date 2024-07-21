------------------------------------
-- Mason, LSP，Linter，DAP Configuration --
------------------------------------
local M = {}

-- mason-lspconfig
M.lsp = {
    -- "asm_lsp",
    -- "bashls",
    -- "clangd",
    -- "cmake",
    "gopls",
    -- "jsonls",
    "marksman",
    "lua_ls",
    "pyright",
    -- "terraformls",
    -- "yamlls",
    -- "html",
}

-- mason-null-ls
M.nls = {
    -- "cmakelang",
    -- "gitlint",
    "goimports",
    --"golangci-lint",
    -- "jsonlint",
    "markdownlint",
    -- "protolint",
    "pylint",
    -- "yamllint",
}

-- mason-nvim-dap
M.dap = {
    "delve",
    -- "cpptools",
    -- "bash-debug-adapter",
}

return M
