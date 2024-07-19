local M = {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = {
        "InsertEnter",
        "CmdlineEnter",
    },
    dependencies = {
        -- snippets
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            event = "InsertEnter",
            build = "make install_jsregexp",
            dependencies = {
                "rafamadriz/friendly-snippets",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
            },
        },
        -- sources
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        -- icon
        "onsails/lspkind-nvim",
    },
}

function M.config()
    local luasnip = require("luasnip")
    local cmp = require("cmp")

    cmp.setup({
        -- Enable LSP snippets
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body) -- For `luasnip` users.
            end,
        },
        mapping = {
            -- Use <C-u/d> to scroll the docs
            ["<C-u>"] = cmp.mapping.scroll_docs(-4),
            ["<C-d>"] = cmp.mapping.scroll_docs(4),
            -- Use <C-n/p> to switch in items
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),
            -- Use <CR>(Enter) to confirm selection
            -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            -- A super tab
            -- sourc: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
            ["<Tab>"] = cmp.mapping(function(fallback)
                -- Hint: if the completion menu is visible select next one
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<C-c>"] = cmp.mapping({
                i = cmp.mapping.abort(),
                s = cmp.mapping.close(),
            })
        },
        -- Installed sources that can be used for code suggestions
        sources = {
            { name = "path" }, -- file paths
            { name = "nvim_lsp", keyword_length = 1, priority = 10 }, -- from language server
            { name = "luasnip", keyword_length = 1, priority = 7 }, -- for lua users
            { name = "nvim_lsp_signature_help", priority = 8 }, -- display function signatures with current parameter emphasized
            { name = "nvim_lua", keyword_length = 1, priority = 8 }, -- complete neovim's Lua runtime API such vim.lsp.*
            { name = "buffer", keyword_length = 1, priority = 5 }, -- source current buffer
        },
        -- Add borders to the windows
        window = {
            completion = cmp.config.window.bordered({
                winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:Search",
            }),
            documentation = cmp.config.window.bordered({
                winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:Search",
            }),
        },
        -- add formating of the different sources
        formatting = {
            format = require("lspkind").cmp_format({
                mode = "symbol_text", -- show only symbol annotations
                maxwidth = 60, -- prevent the popup from showing more than provided characters
                -- The function below will be called before any actual modifications from lspkind
                before = function(entry, vim_item)
                    local menu_icon = {
                        nvim_lsp = "[Lsp]",
                        luasnip = "[Luasnip]",
                        buffer = "[Buffer]",
                        path = "[Path]",
                    }
                    vim_item.menu = menu_icon[entry.source.name]
                    return vim_item
                end,
            }),
        },
        preselect = cmp.PreselectMode.None,
        diagnostics = {
            enable = true,
            icons = {
                hint = "󰌶 ",
                information = " ",
                warning = " ",
                error = " ",
            },
        },
        confirm_opts = {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        },
        experimental = {
            ghost_text = false,
        },
    })

    -- `/` cmdline setup.
    cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = "buffer" },
        },
    })

    -- `:` cmdline setup.
    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = "path" },
        }, {
            { name = "cmdline" },
        }),
    })
end

return M
