local wk = require('which-key')
wk.setup({
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

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
    b = {
        name = "Buffers",
        a = { "<cmd>lua require('Buffers').clear()<cr>", "Close all" },
        b = { "<cmd>Telescope buffers path_display={'truncate'}<cr>", "list-buffers" },
        d = { "<cmd>lua require('Buffers').delete()<cr>", "Kill buffer" },
        D = { "<cmd>lua require('Buffers').only()<cr>", "Kill other buffers..." },
        h = { "<cmd>Alpha<cr>", "Neovim home buffer" },
        n = { "<cmd>bn<cr>", "Next buffer" },
        p = { "<cmd>bp<cr>", "Previous buffer" },
        ["`"] = { "<cmd>e #<cr>", "Switch to Other Buffer" },
        --W = { "<cmd><cr>", "goto-buffer-workspace" }, --todo
    },
    c = {
        name = "compile/comments",
        b = { "<cmd>lua require('Comment.api').toggle.blockwise.current()<cr>", "comment-or-uncomment-blocks" },
        o = { "<cmd>lua require('Comment.api').insert.linewise.below()<cr>", "comment-line-below" },
        O = { "<cmd>lua require('Comment.api').insert.linewise.above()<cr>", "comment-line-above" },
        ["/"] = { "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>", "comment-or-uncomment-lines" },
        ["$"] = { "<cmd>lua require('Comment.api').insert.linewise.eol()<cr>", "comment-end-of-line" },
    },
    --d = {
    --    name = "Debug",
    --    b = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "togle-breakpoint" },
    --    c = { "<cmd>lua require('dap').continue()<cr>", "continue" },
    --    i = { "<cmd>lua require('dap').step_into()<cr>", "step-into" },
    --    o = { "<cmd>lua require('dap').step_over()<cr>", "step-over" },
    --    O = { "<cmd>lua require('dap').step_out()<cr>", "step-out" },
    --    r = { "<cmd>lua require('dap').repl.toggle()<cr>", "repl-toggle" },
    --    l = { "<cmd>lua require('dap').run_last()<cr>", "run-last" },
    --    u = { "<cmd>lua require('dapui').toggle()<cr>", "dapui-toggle" },
    --    t = { "<cmd>lua require('dapui').terminate()<cr>", "teminate" },
    --},

    --D = {
    --    name = "Diff/Compare",
    --    b = {
    --        name = "Buffers",
    --    },
    --    d = {
    --        name = "Directories",
    --    },
    --    f = {
    --        name = "Files",
    --    },
    --    m = {
    --        name = "Merge",
    --    },
    --    r = {
    --        name = "Regions"
    --    },
    --    w = {
    --        name = "Windows"
    --    },
    --},

    --e = {
    --    name = "errors",
    --    ["."] = { "", "error-transient-state" },
    --    n = { "", "next-error" },
    --    p = { "", "previous-error" },
    --    z = { "", "last-error" },
    --},
    f = {
        name = "Files",
        f = { "<cmd>Telescope find_files<cr>", "Find files" },
        --n = { "<cmd>enew<cr>", "+new-file" },
        s = { "<cmd>w!<cr>", "Save a file" },
        --S = { "<cmd>wa!<cr>", "save-all-files" },
        t = { "<cmd>NvimTreeToggle<cr>", "File tree" },
        T = { "<cmd>NvimTreeFindFile<cr>", "Focus current file in file tree" },
    },
    --F = {
    --    name = "Frames"
    --},
    g = {
        name = "git/versions-control",
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        C = { "<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)" },
        d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Git Diff" },
        D = { "<cmd>DiffviewOpen<CR>", "Diff Repo" },
        --l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
        m = { "<cmd>GitMessenger<cr>", "Git Messenger" },
        --n = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk" },
        o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        --p = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev Hunk" },
        --r = { "<cmd>lua require 'gitsigns'.reset_hunk()<CR>", "Reset Hunk" },
        --R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
        --s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
        --u = {
        --    "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
        --    "Undo Stage Hunk",
        --},
    },
    h = {
        name = "help",
        --c = { "<cmd>:Telescope commands<cr>", "Commands" },
        --h = { "<cmd>:Telescope help_tags<cr>", "Help Pages" },
        --k = { "<cmd>:Telescope keymaps<cr>", "Key Maps" },
        --s = { "<cmd>:Telescope highlights<cr>", "Search Highlight Groups" },
        --f = { "<cmd>:Telescope filetypes<cr>", "File Types" },
        --o = { "<cmd>:Telescope vim_options<cr>", "Options" },
        --a = { "<cmd>:Telescope autocommands<cr>", "Auto Commands" },
    },
    --i = {
    --    name = "insertion",
    --},
    j = {
        name = "jump/join/split",
        j = { "<cmd>HopChar1<cr>", "jump-or-select-to-a-character" },
        J = { "<cmd>HopChar2<cr>", "jump-to-suite-of-two-characters" },
        l = { "<cmd>HopLine<cr>", "jump-or-select-to-a-line" },
        p = { "<cmd>HopPattern<cr>", "jump-or-select-to-a-pattern" },
        w = { "<cmd>HopWord<cr>", "jump-to-a-word" },
    },
    l = {
        name = "LSP",
        --["<F2>"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename all reference" },
        --["<F3>"] = { "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format" },
        --["<F4>"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code actions" }
        --d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Jump to definition" },
        --D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Jump to declaration" },
        --i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "List all implementations" },
        --K = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Display hover" },
        --l = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Show diagnostic" },
        --o = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Jump to definition of type symbol" },
        --r = { "<cmd>lua vim.lsp.buf.references()<cr>", "List all references" },
        --s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Display signature" },


        I = { "<cmd>Mason<cr>", "Mason Info" },
        n = {
            "<cmd>lua vim.diagnostic.goto_next()<cr>",
            "Next Diagnostic",
        },
        p = {
            "<cmd>lua vim.diagnostic.goto_prev()<cr>",
            "Prev Diagnostic",
        },
        q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = {
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            "Workspace Symbols",
        },
    },
    p = {
        name = "Packer/Project",
        c = { "<cmd>PackerCompile<cr>", "Compile" },
        i = { "<cmd>PackerInstall<cr>", "Install" },
        r = { "<cmd>PackerClean<cr", "Remove Unused Plugins" },
        s = { "<cmd>PackerSync<cr>", "Sync" },
        S = { "<cmd>PackerStatus<cr>", "Status" },
        u = { "<cmd>PackerUpdate<cr>", "Update" },
    },
    q = {
        name = "Quit",
        q = { "<esc><cmd>qa<cr>", "Quit" },
    },
    s = {
        name = "Search/Symbol",
        b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search in current buffer" },
        f = { "<cmd>Telescope find_files<cr>", "Search files (root dir)" },
        h = { "<cmd>Telescope help_tags<cr>", "Search help tags" },
        p = { "<cmd>lua require('telescope').extensions.project.project{}<cr>", "Search project" },
        r = { "<cmd>Telescope oldfiles<cr>", "Search recent" },
        s = {
            function()
                require("telescope.builtin").lsp_document_symbols({
                    symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module", "Struct", "Trait", "Field", "Property" },
                })
            end,
            "Goto Symbol",
        },
        S = {
            function()
                require("telescope.builtin").lsp_workspace_symbols({
                    symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module", "Struct", "Trait", "Field", "Property" },
                })
            end,
            "Goto Symbol (Workspace)",
        },
        t = { "<cmd>Telescope<cr>", "Telescope" },
        T = { "<cmd>Telescope live_grep<cr>", "Search text" },
    },
    t = {
        name = "TODO",
        n = { "<cmd>lua require('todo-comments').jump_next()<cr>", "Next todo comment" },
        p = { "<cmd>lua require('todo-comments').jump_prev()<cr>", "Previous todo comment" },
        e = { "<cmd>lua require('todo-comments').jump_next({keywords={'ERROR', 'WARNING'}})<cr>", "next-error/warning-todo-comment" },
        l = { "<cmd>TodoLocList<cr>", "TodoLocList" },
        q = { "<cmd>TodoQuickFix<cr>", "TodoQuickFix" },
        s = { "<cmd>TodoTelescope<cr>", "Todo" },
        t = { "<cmd>TodoTrouble<cr>", "Todo (Trouble)" },
    },
    T = {
        name = "Treesitter",
        i = { "<cmd>TSConfigInfo<cr>", "Info" },
    },
    w = {
        name = "Windows",
        c = { "<cmd>lua require('window-picker').pick()<cr>", "Choose a window" },
        d = { "<cmd>wincmd c<cr>", "Close current window" },
        D = { "<cmd>wincmd o<cr>", "Close other windows" },
        h = { "<cmd>wincmd h<cr>", "Go to the left window" },
        H = { "<cmd>wincmd H<cr>", "Move window to far left" },
        j = { "<cmd>wincmd j<cr>", "Go to the down window" },
        J = { "<cmd>wincmd J<cr>", "Move window to far bottom" },
        k = { "<cmd>wincmd k<cr>", "Go to the up window" },
        K = { "<cmd>wincmd K<cr>", "Move window to far top" },
        l = { "<cmd>wincmd l<cr>", "Go to the right window" },
        L = { "<cmd>wincmd L<cr>", "Move window to far right" },
        m = { "<cmd>lua require('maximizer').toggle()<cr>", "Maximize current window" },
        s = { "<cmd>sp<cr>", "Split window" },
        v = { "<cmd>vsp<cr>", "Split window vertically" },
    },
    x = {
        name = "Diagnostics/Quickfix",
        d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics (Trouble)" },
        l = { "<cmd>TroubleToggle loclist<cr>", "Location List (Trouble)" },
        q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix List (Trouble)" },
        w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics (Trouble)" },
        R = { "<cmd>TroubleToggle lsp_references<cr>", "LSP references (Trouble)" },
        x = { "<cmd>TroubleToggle<cr>", "Toggle trouble" },
    },
}
wk.register(mappings, opts)

wk.register({
    c = {
        name = "compile/comment",
        b = { "<esc><cmd>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<cr>", "comment-or-uncomment-blocks" },
        ["/"] = { "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", "comment-or-uncomment-lines" },

    },
}, {
    mode = "v",
    prefix = "<leader>",
})