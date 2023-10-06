local M = {}

-- Lsp servers
M.servers = {
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
}

-- Null-ls servers
M.Nservers = {
  "clang-format",
  "cmakelang",
  "gitlint",
  "goimports",
  "golangci-lint",
  "jsonlint",
  "markdownlint",
  "protolint",
  "pylint",
  "yamllint",
}



return M
