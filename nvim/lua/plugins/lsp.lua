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

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
    lsp.buffer_autoformat()

    local ok, wk = pcall(require, "which-key")
    if not ok then
        return
    end

    local mode_adapters = {
        normal_mode = "n",
    }

    local mappings = {
        normal_mode = {
            ["gb"] = { "<C-t>", "Go back" },
        }
    }

    for mode, keys in pairs(mappings) do
        local mode_adapter = mode_adapters[mode]
        wk.register(keys, { mode = mode_adapter })
    end

    --vim.keymap.set("n", "gb", "<C-t>", { desc = "Go back" })
    --vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', { buffer = true, desc = "Jump to definition" })
    --vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', { buffer = true, desc = "Jump to declaration" })
    --vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', { buffer = true, desc = 'List all implementations' })
    --vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', { buffer = true, desc = 'Show diagnostic' })
    --vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', { buffer = true, desc = 'Jump to definition of type symbol' })
    --vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', { buffer = true, desc = 'List all references' })
    --vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { buffer = true, desc = 'Display signature' })
end)

lsp.setup()

