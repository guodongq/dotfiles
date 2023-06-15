local lsp = require('lsp-zero').preset('recommended')

lsp.ensure_installed({
    "gopls",
    "clangd",
    "marksman",
    --"bashls",
    --"cmake",
    --"jsonls",
    --"yamlls",
})

lsp.setup()