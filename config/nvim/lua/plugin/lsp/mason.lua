require('mason').setup()

require('mason-lspconfig').setup({
    ensure_installed = {
        "sumneko_lua",
        "gopls",
        "clangd",
        "bashls",
        "cmake",
        -- "jdtls",
        "jsonls",
        "yamlls",
        "marksman",
    },
    automatic_installation = true,
})