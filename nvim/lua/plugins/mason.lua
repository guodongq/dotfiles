local map = vim.keymap.set
local fmt_group = vim.api.nvim_create_augroup("FORMATTING", {clear = true})

---Common format-on-save for lsp servers that implements formatting
---@param client table
---@param buf integer
function fmt_on_save(client, buf)
  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = fmt_group,
      buffer = buf,
      callback = function()
        vim.lsp.buf.format({
          timeout_ms = 3000,
          buffer = buf,
        })
      end,
    })
  end
end

---Creates LSP mappings
---@param buf number
function mappings(buf)
  local opts = { buffer = buf }

  map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  map('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  map('i', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  map('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  map('n', '<F3>', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
  map('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  map('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
end


return {
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig"
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = {
          "asm_lsp",
          "bashls",
          "clangd",
          "cmake",
          "gopls",
          "jsonls",
          "marksman",
          "lua_ls",
          "pyright",
          "taplo",
          "terraformls",
          "yamlls",
        },
      })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile"},
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-null-ls").setup({
        automatic_installation = true,
        ensure_installed = {
          "clang-format",
          "cmakelang",
          "gitlint",
          "goimports",
          "golangci-lint",
          "jsonlint",
          "markdownlint",
          "protolint",
          "pylint",
          "yamllint"
        },
      })

      local nls = require("null-ls")
      local fmt = nls.builtins.formatting
      local dgn = nls.builtins.diagnostics
      local cda = nls.builtins.code_actions

      nls.setup({
        sources = {
          ----------------
          --FORMATTING --
          ----------------
          fmt.trim_whitespace.with({
            filetypes = { "text", "zsh", "toml", "make", "conf", "tmux"},
          }),
          -- NOTE
          -- 1. both needs to be enabled to so prettier can apply eslint fixes
          -- 2. prettierd should come first to prevent occassional race condition
          fmt.prettierd,
          fmt.eslint_d,
          -- fmt.prettier.with({
          --   extra_args = {
          --     "--tab-width=4",
          --     "--trailing-comma=es5",
          --     "--end-of-line=lf",
          --     "--arrow-parens=always",
          --   },
          -- }),
          fmt.rustfmt,
          fmt.stylua,
          fmt.gofmt,
          fmt.zigfmt,
          fmt.shfmt.with({
            extra_args = {"-i", 4, "-ci", "-sr"},
          }),
          -----------------
          --DIAGNOSTICS --
          -----------------
          dgn.eslint_d,
          dgn.shellcheck,
          dgn.luacheck.with({
            extra_args = {"--globals", "vim", "--std", "luajit"},
          }),
          ------------------
          --CODE ACTIONS --
          ------------------
          cda.eslint_d,
          cda.shellcheck,
        },
        on_attach = function(client, bufnr)
          fmt_on_save(client, bufnr)
          mappings(bufnr)
        end,
      })
    end,
  }
}
