local M = {}

local map = vim.keymap.set
local fmt_group = vim.api.nvim_create_augroup('FORMATTING', { clear = true })

---Disable formatting for servers | Handled by null-ls
---@param client table
---@see https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
function M.disable_formatting(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = true
end

---LSP servers capabilities w/ nvim-cmp
function M.capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    return require('cmp_nvim_lsp').default_capabilities(capabilities)
end

---Common format-on-save for lsp servers that implements formatting
---@param client table
---@param buf integer
function M.fmt_on_save(client, buf)
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

M.on_attach = function(client)
    vim.cmd [[autocmd ColorScheme * :lua require('vim.lsp.diagnostic')._define_default_signs_and_highlights()]]
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = true
end

---Creates LSP mappings
---@param buf number
function M.mappings(buf)
    local opts = { buffer = buf }

    map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    map('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    map('i', '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- map('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    -- map('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    map('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    map('n', '<leader>c', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- map('v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
    map('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    map('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    map('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    -- map('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    -- map('n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
end

function M.diagnostic()
    -- Automatically update diagnostics
    vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        virtual_text = {
            source = 'always',
            spacing = 4,
            prefix = "●"
        },
        float = {
            source = 'always',
        },
    })

    local lsp = vim.lsp

    lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
        underline = false, -- disable virtual text
        virtual_text = true,
        -- show signs
        signs = true,
        -- delay update diagnostics
        update_in_insert = false,
    })

    local border = {
        { "🭽", "FloatBorder" },
        { "▔", "FloatBorder" },
        { "🭾", "FloatBorder" },
        { "▕", "FloatBorder" },
        { "🭿", "FloatBorder" },
        { "▁", "FloatBorder" },
        { "🭼", "FloatBorder" },
        { "▏", "FloatBorder" },
    }

    lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, {
        border = border,
    })

    lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, {
        border = border,
    })
end

return M