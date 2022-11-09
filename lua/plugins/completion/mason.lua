local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')

mason.setup()
mason_lspconfig.setup({
    ensure_installed = {
        "sumneko_lua",
        "gopls",
        "clangd",
        -- "bashls",
        -- "cmake",
        -- "jdtls",
        -- "jsonls",
        -- "yamlls",
        "marksman",
    },
    automatic_installation = true,
})
