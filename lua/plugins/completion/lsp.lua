local nvim_lsp = require('lspconfig')
local M = require('plugins.completion.utility')

---Common perf related flags for all the LSP servers
local flags = {
    allow_incremental_sync = true,
    debounce_text_changes = 200,
}

---Common capabilities including lsp snippets and autocompletion
local capabilities = M.capabilities()

---Common `on_attach` function for LSP servers
---@param client table
---@param buf integer
local function on_attach(client, buf)
    M.disable_formatting(client)
    M.mappings(buf)
end

-- Disable LSP logging
vim.lsp.set_log_level(vim.lsp.log_levels.OFF)

-- Configuring native diagnostics
M.diagnostic()

-------------------------------------------------------------------
--- List of the LSP server that don't need special configuration --
-------------------------------------------------------------------
local servers = {
    --'zls', -- Zig
    'gopls', -- Golang
    'clangd', -- C
    'marksman', --Markdown
    --'tsserver', -- Typescript
    --'html', -- HTML
    --'cssls', -- CSS
    --'jsonls', -- Json
    --'yamlls', -- YAML
    --'emmet_ls', -- emmet-ls
    -- 'terraformls', -- Terraform
}

for _, server in ipairs(servers) do
    nvim_lsp[server].setup({
        flags = flags,
        capabilities = capabilities,
        on_attach = on_attach,
    })
end

-------------------------------------------------
--- LSP server that need special configuration --
-------------------------------------------------

nvim_lsp.sumneko_lua.setup({
    flags = flags,
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            completion = {
                enable = true,
                showWord = 'Disable',
                -- keywordSnippet = 'Disable',
            },
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = { os.getenv('VIMRUNTIME') },
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})

-- Rust
-- nvim_lsp.rust_analyzer.setup({
--     flags = flags,
--     capabilities = capabilities,
--     on_attach = on_attach,
--     settings = {
--         ['rust-analyzer'] = {
--             cargo = {
--                 allFeatures = true,
--             },
--             checkOnSave = {
--                 allFeatures = true,
--                 command = 'clippy',
--             },
--             procMacro = {
--                 ignored = {
--                     ['async-trait'] = { 'async_trait' },
--                     ['napi-derive'] = { 'napi' },
--                     ['async-recursion'] = { 'async_recursion' },
--                 },
--             },
--         },
--     },
-- })

-- Angular
-- 1. install @angular/language-server globally
-- 2. install @angular/language-service inside project as dev dep
-- nvim_lsp.angularls.setup({
--     flags = flags,
--     capabilities = capabilities,
--     on_attach = function(client, buf)
--         client.server_capabilities.renameProvider = false
--         on_attach(client, buf)
--     end,
-- })
