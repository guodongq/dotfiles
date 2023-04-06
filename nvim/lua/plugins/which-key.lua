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

-- -----------------------------
-- keybindings
-- -----------------------------
local mode_adapters = {
    insert_mode = "i",
    normal_mode = "n",
    term_mode = "t",
    visual_mode = "v",
    visual_block_mode = "x",
    command_mode = "c",
    operator_pending_mode = "o",
}

local mappings = {
    insert_mode = {
        ["jk"] = { "<esc>", "Escape" },
        ["<esc>"] = { "<cmd>noh><cr><esc>", "Escape and clear hlsearch" },
        ["<A-j>"] = { "<esc><cmd>m .+1<cr>==gi", "Move lines down" },
        ["<A-k>"] = { "<esc><cmd>m .-2<cr>==gi", "Move lines up" },
        ["<C-s>"] = { "<cmd>w<cr><esc>", "Save file" },
    },

    normal_mode = {
        -- debug keybindings
        ["F5"] = { "<cmd>lua require('dap').step_into()<cr>", "Step Into(Debugger)" },
        ["F6"] = { "<cmd>lua require('dap').step_over()<cr>", "Step Over(Debugger)" },
        ["F7"] = { "<cmd>lua require('dap').step_out()<cr>", "Step Out(Debugger)" },
        ["F8"] = { "<cmd>lua require('dap').continue()<cr>", "Continue(Debugger)" },
        ["F9"] = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "Toggle Breakpoint(Debugger)" },


        -- better up/down
        ["j"] = { "v:count == 0 ? 'gj' : 'j'", "Better down", expr = true },
        ["k"] = { "v:count == 0 ? 'gk' : 'k'", "Better up", expr = true },

        ["<esc>"] = { "<cmd>noh><cr><esc>", "Escape and clear hlsearch" },
        ["<C-a>"] = { "<Esc>gg<S-v>G<CR>", "Select all" },
        ["<C-s>"] = { "<cmd>w<cr><esc>", "Save file" },

        -- Move to window using the <ctrl> hjkl keys
        ["<C-h>"] = { "<C-w>h", "Go to left window" },
        ["<C-j>"] = { "<C-w>j", "Go to lower window" },
        ["<C-k>"] = { "<C-w>k", "Go to upper window" },
        ["<C-l>"] = { "<C-w>l", "Go to right window" },

        -- Resize window using <ctrl> arrow keys
        ["<C-Up>"] = { "<cmd>resize +2<cr>", "Increase window height" },
        ["<C-Down>"] = { "<cmd>resize -2<cr>", "Decrease window height" },
        ["<C-Left>"] = { "<cmd>vertical resize -2<cr>", "Decrease window width" },
        ["<C-Right>"] = { "<cmd>vertical resize +2<cr>", "Increase window width" },

        -- Move Lines
        ["<A-j>"] = { "<esc><cmd>m .+1<cr>==gi", "Move lines down" },
        ["<A-k>"] = { "<esc><cmd>m .-2<cr>==gi", "Move lines up" },

        ["gw"] = { "*N", "Search word under cursor" },

        -- Fix * (Keep the cursor position, don't move to next match)
        ["*"] = { "*N", "Keep cursor position" },
        -- Fix n and N. Keeping cursor in center
        ["n"] = { "nzz", "Keep cursor in center" },
        ["N"] = { "Nzz", "Keep cursor in center" },


        -- buffers
        ["<leader>b"] = { name = "Buffers" },
        ["<leader>ba"] = { "<cmd>lua require('Buffers').clear()<cr>", "Close all" },
        ["<leader>bd"] = { "<cmd>lua require('Buffers').delete()<cr>", "Kill buffer" },
        ["<leader>bD"] = { "<cmd>lua require('Buffers').only()<cr>", "Kill other buffers..." },
        ["<leader>bh"] = { "<cmd>Alpha<cr>", "Neovim home buffer" },
        ["<leader>bl"] = { "<cmd>Telescope buffers path_display={'truncate'}<cr>", "list-buffers" },
        ["<leader>bn"] = { "<cmd>bn<cr>", "Next buffer" },
        ["<leader>bp"] = { "<cmd>bp<cr>", "Previous buffer" },
        ["<leader>b`"] = { "<cmd>e #<cr>", "Switch to Other Buffer" },
        --["<leader>bW"] = { "<cmd><cr>", "goto-buffer-workspace" },

        -- compile/comments
        ["<leader>c"] = { name = "compile/comments" },
        ["<leader>cb"] = { "<cmd>lua require('Comment.api').toggle.blockwise.current()<cr>", "comment-or-uncomment-blocks" },
        ["<leader>co"] = { "<cmd>lua require('Comment.api').insert.linewise.below()<cr>", "comment-line-below" },
        ["<leader>cO"] = { "<cmd>lua require('Comment.api').insert.linewise.above()<cr>", "comment-line-above" },
        ["<leader>c/"] = { "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>", "comment-or-uncomment-lines" },
        ["<leader>c$"] = { "<cmd>lua require('Comment.api').insert.linewise.eol()<cr>", "comment-end-of-line" },

        -- debug
        ["<leader>d"] = { name = "debug" },
        -- running the program
        ["<leader>dr"] = { name = "Running the program" },
        ["<leader>drr"] = { "<cmd>Telescope dap configurations<cr>", "run" },
        ["<leader>drl"] = { "<cmd>lua require('dap').run_last()<cr>", "run last" },
        ["<leader>drR"] = { "<cmd>lua require('dap').restart()<cr>", "restart" },
        ["<leader>drq"] = { "<cmd>lua require('dap').terminate()<cr>", "terminate" },

        -- steps
        ["<leader>ds"] = { name = "steps" },
        ["<leader>dsp"] = { "<cmd>lua require('dap').step_back()<cr>", "step back" }, -- [p]revious
        ["<leader>dsn"] = { "<cmd>lua require('dap').step_over()<cr>", "step over" }, -- [n]ext
        ["<leader>dsi"] = { "<cmd>lua require('dap').step_into()<cr>", "step into" }, -- [i]nto
        ["<leader>dso"] = { "<cmd>lua require('dap').step_out()<cr>", "step out" }, -- [o]ut, [u]ninto
        ["<leader>dsc"] = { "<cmd>lua require('dap').continue()<cr>", "continue" }, -- Run until breakpoint or program termination
        ["<leader>dsh"] = { "<cmd>lua require('dap').run_to_cursor()<cr>", "step to here(cursor)" }, -- step to [h]ere

        -- breakpoint
        ["<leader>db"] = { name = "breakpoints" },
        ["<leader>dbb"] = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "toggle breakpoint" },
        ["<leader>dbB"] = { "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", "conditional breakpoint" },
        ["<leader>dbl"] = { "<cmd>Telescope dap list_breakpoints<cr>", "show all breakpoints" },
        ["<leader>dbx"] = { "<cmd>lua require('dap').clear_breakpoints()<cr>", "removes all breakpoints" },

        -- dapui
        ["<leader>du"] = { name = "dapui" },
        ["<leader>dui"] = { "<cmd>lua require('dapui').toggle()<cr>", "toggle dapui" },

        -- watch expression
        ["<leader>de"] = { name = "expressions" },
        ["<leader>dek"] = { "<cmd>lua require('dapui').eval()", "eval" },
        ["<leader>deK"] = { "<cmd>lua require('dap.ui.widgets').preview()<cr>", "preview expression" },

        -- files
        ["<leader>f"] = { name = "Files" },
        ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find files" },
        ["<leader>fn"] = { "<cmd>enew<cr>", "+New file" },
        ["<leader>fr"] = { "<cmd>NvimTreeRefresh<cr>", "Refresh file tree" },
        ["<leader>fs"] = { "<cmd>w!<cr>", "Save a file" },
        ["<leader>ft"] = { "<cmd>NvimTreeToggle<cr>", "File tree" },
        ["<leader>fT"] = { "<cmd>NvimTreeFindFile<cr>", "Focus current file in file tree" },

        -- git
        ["<leader>g"] = { name = "git/versions-control" },
        ["<leader>gb"] = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        ["<leader>gc"] = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        ["<leader>gC"] = { "<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)" },
        ["<leader>gD"] = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff this HEAD" },

        ["<leader>gd"] = { name = "Diffview" },
        ["<leader>gdn"] = { "<cmd>DiffviewOpen<cr>", "Diffview opened" },
        ["<leader>gdd"] = { "<cmd>DiffviewClose<cr>", "Diffview close" },


        ["<leader>gm"] = { "<cmd>GitMessenger<cr>", "Reveal commit messages" },
        ["<leader>go"] = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        ["<leader>gs"] = { "<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk" },
        ["<leader>gr"] = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk" },

        -- help
        ["<leader>h"] = { name = "help" },
        ["<leader>hr"] = { "<cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><cr>", "Redraw/Clear hlsearch/Diff update" }, -- Clear search, diff update and redraw, taken from runtime/lua/_editor.lua

        -- jump/join/split
        ["<leader>j"] = { name = "jump/join/split" },
        ["<leader>jj"] = { "<cmd>HopChar1<cr>", "jump-or-select-to-a-character" },
        ["<leader>jJ"] = { "<cmd>HopChar2<cr>", "jump-to-suite-of-two-characters" },
        ["<leader>jl"] = { "<cmd>HopLine<cr>", "jump-or-select-to-a-line" },
        ["<leader>jp"] = { "<cmd>HopPattern<cr>", "jump-or-select-to-a-pattern" },
        ["<leader>jw"] = { "<cmd>HopWord<cr>", "jump-to-a-word" },

        -- lsp keybindings(register in lsp configuration)
        ["<leader>l"] = { name = "LSP" },
        ["<leader>lb"] = { "<C-t>", "Go back to stack frames" },

        ["<leader>lc"] = { name = "Code" },
        ["<leader>lca"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        ["<leader>lcf"] = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format Buffer" },

        ["<leader>ld"] = { name = "Definition" },
        ["<leader>ldd"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to Lsp Definition" },
        ["<leader>ldD"] = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Go to Lsp Type Definition" },

        ["<leader>lD"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to Lsp Declaration" },
        ["<leader>li"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Go to Lsp Implementation" },
        ["<leader>lK"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Show Lsp Hover" },

        ["<leader>lr"] = { name = "Rename" },
        ["<leader>lrn"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename Lsp Symbol" },
        ["<leader>lrs"] = { "<cmd>lua require('spectre').open()<cr>", "Replace in files (Spectre)" },

        ["<leader>lR"] = { "<cmd>lua vim.lsp.buf.references()<cr>", "Show Lsp References" },
        ["<leader>lo"] = { "<cmd>SymbolsOutline<cr>", "Show SymbolsOutline" },
        ["<leader>lI"] = { "<cmd>Mason<cr>", "Mason Info" },
        ["<leader>ls"] = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        ["<leader>lS"] = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },

        ["<leader>lq"] = { name = "Diagnostic" },
        ["<leader>lqp"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
        ["<leader>lqn"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic", },
        ["<leader>lqq"] = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
        ["<leader>lql"] = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Show diagnostic" },

        ["<leader>lh"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Display signature" },

        -- packer/project
        ["<leader>p"] = { name = "Packer/Project" },
        ["<leader>ps"] = { "<cmd>PackerSync<cr>", "Packer Sync" },

        -- quit
        ["<leader>q"] = { name = "Quit" },
        ["<leader>qq"] = { "<esc><cmd>qa<cr>", "Quit neovim" },

        -- search/symbol
        ["<leader>s"] = { name = "Search/Symbol" },
        ["<leader>sb"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search in current buffer" },
        ["<leader>sf"] = { "<cmd>Telescope find_files<cr>", "Search files (root dir)" },
        ["<leader>sh"] = { "<cmd>Telescope help_tags<cr>", "Search help tags" },
        ["<leader>sp"] = { "<cmd>lua require('telescope').extensions.projects.projects{}<cr>", "Search project" },
        ["<leader>sr"] = { "<cmd>Telescope oldfiles<cr>", "Search recent" },
        ["<leader>ss"] = {
            function()
                require("telescope.builtin").lsp_document_symbols({
                    symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module", "Struct", "Trait", "Field", "Property" },
                })
            end,
            "Goto Symbol",
        },
        ["<leader>sS"] = {
            function()
                require("telescope.builtin").lsp_workspace_symbols({
                    symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module", "Struct", "Trait", "Field", "Property" },
                })
            end,
            "Goto Symbol (Workspace)",
        },
        ["<leader>st"] = { "<cmd>Telescope<cr>", "Search (Telescope)" },
        ["<leader>sT"] = { "<cmd>Telescope live_grep<cr>", "Search text" },

        -- todo
        ["<leader>t"] = { name = "TODO" },
        ["<leader>tl"] = { "<cmd>TodoLocList<cr>", "Todo (TodoLocList)" },
        ["<leader>tn"] = { "<cmd>lua require('todo-comments').jump_next()<cr>", "Next todo comment" },
        ["<leader>tp"] = { "<cmd>lua require('todo-comments').jump_prev()<cr>", "Previous todo comment" },
        ["<leader>tq"] = { "<cmd>TodoQuickFix<cr>", "Todo (TodoQuickFix)" },
        ["<leader>ts"] = { "<cmd>TodoTelescope<cr>", "Todo (TodoTelescope)" },
        ["<leader>tt"] = {
            function()
                require("todo-comments").jump_next({ keywords = { "ERROR", "WARNING" } })
            end,
            "Next error/warning todo comment"
        },

        -- windows
        ["<leader>w"] = { name = "Windows" },
        ["<leader>wc"] = { "<cmd>lua require('window-picker').pick()<cr>", "Choose a window" },
        ["<leader>wd"] = { "<cmd>wincmd c<cr>", "Close current window" },
        ["<leader>wD"] = { "<cmd>wincmd o<cr>", "Close other windows" },
        ["<leader>wh"] = { "<cmd>wincmd h<cr>", "Go to the left window" },
        ["<leader>wH"] = { "<cmd>wincmd H<cr>", "Move window to far left" },
        ["<leader>wj"] = { "<cmd>wincmd j<cr>", "Go to the down window" },
        ["<leader>wJ"] = { "<cmd>wincmd J<cr>", "Move window to far bottom" },
        ["<leader>wk"] = { "<cmd>wincmd k<cr>", "Go to the up window" },
        ["<leader>wK"] = { "<cmd>wincmd K<cr>", "Move window to far top" },
        ["<leader>wl"] = { "<cmd>wincmd l<cr>", "Go to the right window" },
        ["<leader>wL"] = { "<cmd>wincmd L<cr>", "Move window to far right" },
        ["<leader>wm"] = { "<cmd>lua require('maximizer').toggle()<cr>", "Maximize current window" },
        ["<leader>ws"] = { "<cmd>sp<cr>", "Split window" },
        ["<leader>wv"] = { "<cmd>vsp<cr>", "Split window vertically" },

        -- quickfix
        ["<leader>x"] = { name = "Diagnostics/Quickfix" },
        ["<leader>xd"] = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics (Trouble)" },
        ["<leader>xl"] = { "<cmd>TroubleToggle loclist<cr>", "Location List (Trouble)" },
        ["<leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix List (Trouble)" },
        ["<leader>xw"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics (Trouble)" },
        ["<leader>xR"] = { "<cmd>TroubleToggle lsp_references<cr>", "LSP references (Trouble)" },
        ["<leader>xx"] = { "<cmd>TroubleToggle<cr>", "Toggle trouble" },
    },

    visual_mode = {
        -- Move Lines
        ["<A-j>"] = { "<esc><cmd>m .+1<cr>==gi", "Move lines down" },
        ["<A-k>"] = { "<esc><cmd>m .-2<cr>==gi", "Move lines up" },
        -- better indenting
        ["<"] = { "<gv", "Better indenting" },
        [">"] = { ">gv", "Better indenting" },

        -- git
        ["<leader>g"] = { name = "git/versions-control" },
        ["<leader>gs"] = { "<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk" },
        ["<leader>gr"] = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk" },
    },

    visual_block_mode = {
        ["gw"] = { "*N", "Search word under cursor" },

        -- compile/comment
        ["<leader>c"] = { name = "compile/comment" },
        ["<leader>cb"] = { "<esc><cmd>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<cr>", "comment-or-uncomment-blocks" },
        ["<leader>c/"] = { "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", "comment-or-uncomment-lines" },
    },

    term_mode = {
        -- normal mode shortcut
        ["<esc>"] = { [[<C-\><C-n>]], "Normal Mode" },

        -- window keybindings
        ["<C-j>"] = { [[<C-\><C-n><C-w>j]], "Move to Left Window" },
        ["<C-k>"] = { [[<C-\><C-n><C-w>k]], "Move to Bottom Window" },
        ["<C-h>"] = { [[<C-\><C-n><C-w>h]], "Move to Top Window" },
        ["<C-l>"] = { [[<C-\><C-n><C-w>l]], "Move to Right Window" },
        ["<C-Up>"] = { [[<C-\><C-n><cmd>resize -2<cr>i]], "Resize Window Up" },
        ["<C-Down>"] = { [[<C-\><C-n><cmd>resize +2<cr>i]], "Resize Window Down" },
        ["<C-Left>"] = { [[<C-\><C-n><cmd>vertical resize -2<cr>i]], "Resize Window Left" },
        ["<C-Right>"] = { [[<C-\><C-n><cmd>vertical resize +2<cr>i]], "Resize Window Right" },

    }
}

for mode, keys in pairs(mappings) do
    local mode_adapter = mode_adapters[mode]
    wk.register(keys, { mode = mode_adapter })
end