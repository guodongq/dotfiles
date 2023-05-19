local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")

null_ls.setup({
    -- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
    debug = false,
  	sources = {
      -- go
      -- null_ls.builtins.diagnostics.golangci_lint,
      -- null_ls.builtins.formatting.gofumpt,
      -- null_ls.builtins.formatting.goimports,
      -- null_ls.builtins.formatting.golines,
      -- markdown
      -- null_ls.builtins.diagnostics.markdownlint,
      -- null_ls.builtins.formatting.markdownlint,
      -- shell
      -- null_ls.builtins.code_actions.shellcheck,
      -- null_ls.builtins.formatting.shfmt,
      -- frontend
      -- null_ls.builtins.formatting.prettier,
      -- make
      -- null_ls.builtins.diagnostics.checkmake,
      -- vim
      -- null_ls.builtins.diagnostics.vint,
	  },
})
