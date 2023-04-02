require('which-key').setup({
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object lsp
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },
    -- add operators that will trigger motion and text object lsp
    -- to enable all native operators, set the preset / operators plugin above
    operators = { gc = "Comments" },
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
    },
    motions = {
        count = true,
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
        border = "double", -- none, single, double, shadow, rounded
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        --padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
    },
    --ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    show_keys = true, -- show the currently pressed key and its label as a message in the command line
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    -- list of triggers, where WhichKey should not wait for timeoutlen and show immediately
    triggers_nowait = {
        -- marks
        "`",
        "'",
        "g`",
        "g'",
        -- registers
        '"',
        "<c-r>",
        -- spelling
        "z=",
    },
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
    },
    -- disable the WhichKey popup for certain buf types and file types.
    -- Disabled by deafult for Telescope
    disable = {
        buftypes = {},
        filetypes = {},
    },
})
--    --d = {
--    --    name = "Debug",
--    --    b = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "togle-breakpoint" },
--    --    c = { "<cmd>lua require('dap').continue()<cr>", "continue" },
--    --    i = { "<cmd>lua require('dap').step_into()<cr>", "step-into" },
--    --    o = { "<cmd>lua require('dap').step_over()<cr>", "step-over" },
--    --    O = { "<cmd>lua require('dap').step_out()<cr>", "step-out" },
--    --    r = { "<cmd>lua require('dap').repl.toggle()<cr>", "repl-toggle" },
--    --    l = { "<cmd>lua require('dap').run_last()<cr>", "run-last" },
--    --    u = { "<cmd>lua require('dapui').toggle()<cr>", "dapui-toggle" },
--    --    t = { "<cmd>lua require('dapui').terminate()<cr>", "teminate" },
--    --},
--    l = {
--        name = "LSP",
--        --["<F2>"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename all reference" },
--        --["<F3>"] = { "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format" },
--        --["<F4>"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code actions" }
--        --d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Jump to definition" },
--        --D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Jump to declaration" },
--        --i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "List all implementations" },
--        --K = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Display hover" },
--        --l = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Show diagnostic" },
--        --o = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Jump to definition of type symbol" },
--        --r = { "<cmd>lua vim.lsp.buf.references()<cr>", "List all references" },
--        --s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Display signature" },
--
--
--        I = { "<cmd>Mason<cr>", "Mason Info" },
--        n = {
--            "<cmd>lua vim.diagnostic.goto_next()<cr>",
--            "Next Diagnostic",
--        },
--        p = {
--            "<cmd>lua vim.diagnostic.goto_prev()<cr>",
--            "Prev Diagnostic",
--        },
--        q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
--        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
--        S = {
--            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
--            "Workspace Symbols",
--        },
--    },