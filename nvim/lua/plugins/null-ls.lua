local nls = require('null-ls')

local fmt = nls.builtins.formatting
local dgn = nls.builtins.diagnostics
local cda = nls.builtins.code_actions

-- Configuring null-ls
nls.setup({
    sources = {
        ----------------
        -- FORMATTING --
        ----------------
        fmt.trim_whitespace.with({
            filetypes = { 'text', 'zsh', 'toml', 'make', 'conf', 'tmux' },
        }),
        -- NOTE:
        -- 1. both needs to be enabled to so prettier can apply eslint fixes
        -- 2. prettierd should come first to prevent occassional race condition
        fmt.prettierd,
        fmt.eslint_d,
        -- fmt.prettier.with({
        --     extra_args = {
        --         '--tab-width=4',
        --         '--trailing-comma=es5',
        --         '--end-of-line=lf',
        --         '--arrow-parens=always',
        --     },
        -- }),
        fmt.rustfmt,
        fmt.stylua,
        fmt.gofmt,
        fmt.zigfmt,
        fmt.shfmt.with({
            extra_args = { '-i', 4, '-ci', '-sr' },
        }),
        -----------------
        -- DIAGNOSTICS --
        -----------------
        dgn.eslint_d,
        dgn.shellcheck,
        dgn.luacheck.with({
            extra_args = { '--globals', 'vim', '--std', 'luajit' },
        }),
        ------------------
        -- CODE ACTIONS --
        ------------------
        cda.eslint_d,
        cda.shellcheck,
    },
    on_attach = function(client, bufnr)
        fmt_on_save(client, bufnr)
        mappings(bufnr)
    end,
})

----------------
--- function ---
----------------
local map = vim.keymap.set

local fmt_group = vim.api.nvim_create_augroup('FORMATTING', { clear = true })

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