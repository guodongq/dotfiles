local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(_, bufnr)
  -- see: help lsp-zero-keybindin
  -- to learn the available actions
  lsp_zero.default_keymaps({ buffer = bufnr })
end)

-- Automatic install of language servers
require('mason').setup({})
require('mason-lspconfig').setup({
  -- "cmake", 'jsonls', 'yamlls', "terraformls", "bufls", "asm_lsp"
  ensure_installed = { 'gopls', 'clangd', 'marksman', 'bashls' },
  handlers = {
    lsp_zero.default_setup,
  },
})

-- Completion item label
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local cmp_format = require('lsp-zero').cmp_format()

cmp.setup({
  formatting = cmp_format,
  mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({ select = false }),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  }),
})
