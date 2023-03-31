local null_ls = require('null-ls')

null_ls.setup({
    sources = {
        -- Replace these with the tools you have installed
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.formatting.stylua,
    }
})