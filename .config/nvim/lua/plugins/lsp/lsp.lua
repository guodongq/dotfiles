local M = {
    "neovim/nvim-lspconfig",
    lazy = false,
    event = { "BufReadPre" },
    dependencies = {
        -- cmp
        "hrsh7th/cmp-nvim-lsp",
        -- mason
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        -- outline
        {
            "stevearc/aerial.nvim",
            dependencies = {
                "nvim-treesitter/nvim-treesitter",
                "nvim-tree/nvim-web-devicons",
            },
        },
        -- spectre
        {
            "nvim-pack/nvim-spectre",
            build = false,
            cmd = "Spectre",
            opts = { open_cmd = "noswapfile vnew" },
            -- stylua: ignore
        },
        -- cursorline
        "RRethy/vim-illuminate",
        -- LSP signature hint as you type
        "ray-x/lsp_signature.nvim",
    },
}

function M.lsp_keymaps(bufnr)
    local keymap = vim.api.nvim_buf_set_keymap
    local desc = require("util.kit").desc
    keymap(
            bufnr,
            "n",
            "gd",
            "<cmd>lua require('telescope.builtin').lsp_definitions({ reuse_win = true})<cr>",
            desc("Goto Definition")
    )
    keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<cr>", desc("References"))
    keymap(
            bufnr,
            "n",
            "gI",
            "<cmd>lua require('telescope.builtin').lsp_implementations({ reuse_win = true})<cr>",
            desc("Goto Implementation")
    )
    keymap(
            bufnr,
            "n",
            "gy",
            "<cmd>lua require('telescope.builtin').lsp_type_definitions({ reuse_win = true})<cr>",
            desc("Goto T[y]pe Definition")
    )
    keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", desc("Goto Declaration"))
    keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", desc("Hover"))
    keymap(bufnr, "n", "gK", "<cmd>lua vim.lsp.buf.signature_help()<cr>", desc("Signature Help"))
    keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", desc("Float diagnostic"))
    keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", desc("Lsp info"))
    keymap(bufnr, "n", "<leader>lI", "<cmd>Mason<cr>", desc("Mason"))
    keymap(bufnr, "n", "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc("Goto Code Action"))
    keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", desc("Format file"))
    keymap(bufnr, "n", "<leader>ln", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", desc("Next diagnostic"))
    keymap(bufnr, "n", "<leader>lo", "<cmd>AerialToggle!<cr>", desc("Toggle Outline"))
    keymap(bufnr, "n", "<leader>lp", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", desc("Previous diagnostic"))
    keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc("Rename"))
    keymap(bufnr, "n", "<leader>lR", "<cmd>lua require('spectre').open()<cr>", desc("Replace in Files (Spectre)"))
    keymap(bufnr, "n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc("Document Symbols"))
    keymap(bufnr, "n", "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc("Workspace Symbols"))
    keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc("Setloclist"))
end

function M.on_attach(client, bufnr)
    M.lsp_keymaps(bufnr)
    require("illuminate").on_attach(client)

    require("lsp_signature").on_attach({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
            border = "rounded",
        },
    }, bufnr)

    if client.supports_method("textDocument/inlayHint") then
        if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buftype == "" then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
    end

    if client.supports_method("textDocument/codeLens") then
        vim.lsp.codelens.refresh()
        vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
            buffer = bufnr,
            callback = vim.lsp.codelens.refresh,
        })
    end
end

function M.common_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    return vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
end

function M.config()
    ----------------------------------------
    -- Mason --
    ----------------------------------------
    require("mason").setup()
    require("mason-lspconfig").setup({
        ensure_installed = require("util.mason").lsp,
        automatic_installation = true,
    })
    ----------------------------------------
    -- Aerial --
    ----------------------------------------
    require("aerial").setup()
    ----------------------------------------
    -- Spectre --
    ----------------------------------------
    require("spectre").setup()
    ----------------------------------------
    -- LspConfig --
    ----------------------------------------
    local lspconfig = require("lspconfig")

    -- Configuration
    for _, server in pairs(require("util.mason").lsp) do
        local opts = {
            on_attach = M.on_attach,
            capabilities = M.common_capabilities(),
        }

        server = vim.split(server, "@")[1]

        local require_ok, conf_opts = pcall(require, "plugins.lsp.settings." .. server)
        if require_ok then
            opts = vim.tbl_deep_extend("force", conf_opts, opts)
        end

        lspconfig[server].setup(opts)
    end

    -- Diagnostic
    local default_diagnostic_config = {
        signs = {
            active = true,
            values = {
                { name = "DiagnosticSignError", text = "" },
                { name = "DiagnosticSignWarn", text = "" },
                { name = "DiagnosticSignHint", text = "" },
                { name = "DiagnosticSignInfo", text = "" },
            },
        },
        virtual_text = false,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(default_diagnostic_config)

    for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
    end

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
    require("lspconfig.ui.windows").default_options.border = "rounded"
end

return M
