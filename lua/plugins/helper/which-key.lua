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
            operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = false, -- adds help for motions
            text_objects = false, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
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
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
    },
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<cr>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
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
    -- ["1"] = { "<cmd>BufferLineGoToBuffer 1<cr>", "window-1" },
    -- ["2"] = { "<cmd>BufferLineGoToBuffer 2<cr>", "window-2" },
    -- ["3"] = { "<cmd>BufferLineGoToBuffer 3<cr>", "window-3" },
    -- ["4"] = { "<cmd>BufferLineGoToBuffer 4<cr>", "window-4" },
    -- ["5"] = { "<cmd>BufferLineGoToBuffer 5<cr>", "window-5" },
    -- ["6"] = { "<cmd>BufferLineGoToBuffer 6<cr>", "window-6" },
    -- ["7"] = { "<cmd>BufferLineGoToBuffer 7<cr>", "window-7" },
    -- ["8"] = { "<cmd>BufferLineGoToBuffer 8<cr>", "window-8" },
    -- ["9"] = { "<cmd>BufferLineGoToBuffer 9<cr>", "window-9" },
    a = {
        name = "Applications",
        o = { "<cmd>TodoTelescope<cr>", "open-todo-manager" },
    },
    b = {
        name = "Buffers",
        d = { "<cmd>Bdelete<cr>", "delete-this-buffer" },
        D = { "<cmd>:bufdo :Bdelete<cr>", "delete-all-buffers" },
        h = { "<cmd>Alpha<cr>", "open-welcome-screen" },
        H = { "<cmd>BufferLineCloseLeft<cr>", "delete-all-left-buffers" },
        j = { "<cmd>BufferLinePick<cr>", "jump-to-selected-buffer" },
        l = { "<cmd>Telescope buffers path_display={'truncate'}<cr>", "list-all-buffers" },
        L = { "<cmd>BufferLineCloseRight<cr>", "delete-all-right-buffers" },
        n = { "<cmd>BufferLineCycleNext<cr>", "next-buffer" },
        p = { "<cmd>BufferLineCyclePrev<cr>", "previous-buffer" },
    },
    c = {
        name = "Comment",
        A = { "<cmd>lua require('Comment.api').insert.linewise.eol()<cr>", "comment-insert-end-of-block" },
        b = { "<cmd>lua require('Comment.api').toggle.blockwise.current()<cr>", "comment-toggle-current-block" },
        c = { "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>", "comment-toggle-current-line" },
        o = { "<cmd>lua require('Comment.api').insert.linewise.below()<cr>", "comment-insert-below" },
        O = { "<cmd>lua require('Comment.api').insert.linewise.above()<cr>", "comment-insert-above" },
    },
    d = {
        name = "Debug",
        b = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "togle-breakpoint" },
        c = { "<cmd>lua require('dap').continue()<cr>", "continue" },
        i = { "<cmd>lua require('dap').step_into()<cr>", "step-into" },
        o = { "<cmd>lua require('dap').step_over()<cr>", "step-over" },
        O = { "<cmd>lua require('dap').step_out()<cr>", "step-out" },
        r = { "<cmd>lua require('dap').repl.toggle()<cr>", "repl-toggle" },
        l = { "<cmd>lua require('dap').run_last()<cr>", "run-last" },
        u = { "<cmd>lua require('dapui').toggle()<cr>", "dapui-toggle" },
        t = { "<cmd>lua require('dapui').terminate()<cr>", "teminate" },
    },
    f = {
        name = "File",
        n = { "<cmd>enew<cr>", "+new-file" },
        r = { "<cmd>NvimTreeRefresh<cr>", "refresh-file-tree" },
        s = { "<cmd>w!<cr>", "save-current-file" },
        S = { "<cmd>wa!<cr>", "save-all-files" },
        t = { "<cmd>NvimTreeToggle<cr>", "toggle-file-tree" },
        T = { "<cmd>NvimTreeFindFile<cr>", "show-file-tree" },
    },
    g = {
        name = "Git",
        b = { "<cmd>Telescope git_branches<cr>", "checkout-branch" },
        c = { "<cmd>Telescope git_commits<cr>", "checkout-commit" },
        f = { "<cmd>Telescope git_status<cr>", "open-changed-file" },
        s = { "<cmd>lua require 'gitsigns'.stage_hunk()<CR>", "stage-hunk" },
        S = { "<cmd>lua require 'gitsigns'.stage_buffer()<CR>", "stage-buffer" },
        r = { "<cmd>lua require 'gitsigns'.reset_hunk()<CR>", "reset-hunk" },
        R = { "<cmd>lua require 'gitsigns'.reset_buffer()<CR>", "reset-buffer" },
        u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>", "undo-stage-hunk" },
        p = { "<cmd>lua require 'gitsigns'.preview_hunk()<CR>", "preview-hunk" },
        d = { "<cmd>lua require 'gitsigns'.diffthis()<CR>", "view-diff-of-this-file" },
        D = { "<cmd>DiffviewOpen<CR>", "diff-of-the-repo" },
    },
    h = {
        name = "Help",
        t = { "<cmd>:Telescope builtin<cr>", "Telescope" },
        c = { "<cmd>:Telescope commands<cr>", "Commands" },
        h = { "<cmd>:Telescope help_tags<cr>", "Help Pages" },
        m = { "<cmd>:Telescope man_pages<cr>", "Man Pages" },
        k = { "<cmd>:Telescope keymaps<cr>", "Key Maps" },
        s = { "<cmd>:Telescope highlights<cr>", "Search Highlight Groups" },
        l = { [[<cmd>TSHighlightCapturesUnderCursor<cr>]], "Highlight Groups at cursor" },
        f = { "<cmd>:Telescope filetypes<cr>", "File Types" },
        o = { "<cmd>:Telescope vim_options<cr>", "Options" },
        a = { "<cmd>:Telescope autocommands<cr>", "Auto Commands" },
        p = {
            name = "+packer",
            p = { "<cmd>PackerSync<cr>", "Sync" },
            s = { "<cmd>PackerStatus<cr>", "Status" },
            i = { "<cmd>PackerInstall<cr>", "Install" },
            c = { "<cmd>PackerCompile<cr>", "Compile" },
        },
    },
    j = {
        name = "Jump",
        c = { "<cmd>HopChar1<cr>", "hop-1-character" },
        C = { "<cmd>HopChar2<cr>", "hop-2-characters" },
        l = { "<cmd>HopLine<cr>", "hop-line" },
        p = { "<cmd>HopPattern<cr>", "hop-pattern" },
        w = { "<cmd>HopWord<cr>", "hop-word" },
    },
    l = {
        name = "LSP",
        a = { '<cmd>lua vim.lsp.buf.code_action()<cr>', "code-action" },
        d = { '<cmd>lua vim.lsp.buf.definition()<cr>', "Goto Definition" },
        D = { '<cmd>lua vim.lsp.buf.declaration()<cr>', "Goto Declaration" },
        f = { '<cmd>lua vim.lsp.buf.formatting()<cr>', "format-file" },
        h = { '<cmd>lua vim.lsp.buf.hover()<cr>', "show-hover-doc" },
        i = { '<cmd>lua vim.lsp.buf.implementation', "implementation" },
        I = { '<cmd>Mason<cr>', "install-lsp-server" },
        s = { '<cmd>lua vim.lsp.buf.references()<cr>', "References" },
        R = { '<cmd>lua vim.lsp.buf.rename()<cr>', "rename" },
        o = { '<cmd>SymbolsOutline<cr>', "symbols-outline" },
        S = { '<cmd>lua vim.lsp.buf.signature_help()<cr>', "signature" },
        w = {
            name = "workspace",
            a = { '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', "add-workspace-folder" },
            r = { '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', "remove-workspace-folder" },
            l = { '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', "print-workspace-folder" },
        }
    },
    p = {
        name = "Project",
    },
    q = {
        name = "Quit",
        q = { "<esc><cmd>q<cr>", "prompt-kill-neovim" },
        Q = { "<esc><cmd>wqa!<cr>", "kill-neovim" },
    },
    s = {
        name = "Search/Symbol",
        ["/"] = { "<cmd>Telescope search_history<cr>", "history" },
        [":"] = { "<cmd>Telescope command_history<cr>", "commands" },
        b = { "<cmd>Telescope buffers<cr>", "open buffers" },
        B = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "search-in-current-buffer" },
        f = { "<cmd>Telescope find_files<cr>", "find-file" },
        g = { "<cmd>Telescope git_status<cr>", "find-git-status" },
        h = { "<cmd>Telescope help_tags<cr>", "find-help-tags" },
        p = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "search-project" },
        r = { "<cmd>Telescope oldfiles<cr>", "find-recent-files" },
        s = {
            function()
                require("telescope.builtin").lsp_document_symbols({
                    symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module", "Struct", "Trait" },
                })
            end,
            "Goto Symbol",
        },
        --s = { "<cmd>Telescope lsp_document_symbols<cr>", "find-lsp-document-symbols" },
        t = { "<cmd>Telescope live_grep<cr>", "find-text" },
        T = { "<cmd>TodoTelescope<cr>", "find-todo-telescope" },
    },
    t = {
        name = "Trouble",
        d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document diagnostics" },
        l = { "<cmd>TroubleToggle loclist<cr>", "Loclist" },
        q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
        R = { "<cmd>TroubleToggle lsp_references<cr>", "LSP references" },
        w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace diagnostics" },
        x = { "<cmd>TroubleToggle<cr>", "Toggle trouble" },
    },
    T = {
        name = "TODO",
        n = { "<cmd>lua require('todo-comments').jump_next()<cr>", "next-todo-comment" },
        p = { "<cmd>lua require('todo-comments').jump_prev()<cr>", "previous-todo-comment" },
        e = { "<cmd>lua require('todo-comments').jump_next({keywords={'ERROR', 'WARNING'}})<cr>", "next-error/warning-todo-comment" },
        l = { "<cmd>TodoLocList<cr>", "TodoLocList" },
        q = { "<cmd>TodoQuickFix<cr>", "TodoQuickFix" },
        s = { "<cmd>TodoTelescope<cr>", "TodoTelescope" },
        t = { "<cmd>TodoTrouble<cr>", "TodoTrouble" },
    },
    w = {
        name = "Windows",
        c = { "<cmd>lua require('window-picker').pick()<cr>", "choose-window" },
        d = { "<cmd>wincmd c<cr>", "delete-window" },
        h = { "<cmd>wincmd h<cr>", "window-left" },
        H = { "<cmd>wincmd H<cr>", "window-move-far-left" },
        j = { "<cmd>wincmd j<cr>", "window-down" },
        J = { "<cmd>wincmd J<cr>", "window-move-very-bottom" },
        k = { "<cmd>wincmd k<cr>", "window-up" },
        K = { "<cmd>wincmd K<cr>", "window-move-very-top" },
        l = { "<cmd>wincmd l<cr>", "window-right" },
        L = { "<cmd>wincmd L<cr>", "window-move-far-right" },
        m = { "<cmd>lua require('maximizer').toggle()<cr>", "maximize-window" },
        s = { "<cmd>sp<cr>", "split-windows-below" },
        v = { "<cmd>vsp<cr>", "split-windows-right" },
    },
}
wk.register(mappings, opts)

local vmappings = {
    c = {
        name = "compile/comment",
        c = { "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", "toggle-comment" },
    },
}

local vopts = {
    mode = "v", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}
wk.register(vmappings, vopts)
