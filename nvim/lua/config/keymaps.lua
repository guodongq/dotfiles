local wk = require('which-key')

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

        -- files
        ["<leader>f"] = { name = "Files" },
        ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find files" },
        ["<leader>fn"] = { "<cmd>enew<cr>", "+New file" },
        ["<leader>fs"] = { "<cmd>w!<cr>", "Save a file" },
        ["<leader>ft"] = { "<cmd>NvimTreeToggle<cr>", "File tree" },
        ["<leader>fT"] = { "<cmd>NvimTreeFindFile<cr>", "Focus current file in file tree" },

        -- git
        ["<leader>g"] = { name = "git/versions-control" },
        ["<leader>gb"] = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        ["<leader>gc"] = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        ["<leader>gC"] = { "<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)" },
        ["<leader>gd"] = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff this HEAD" },
        ["<leader>gD"] = { "<cmd>DiffviewOpen<cr>", "Diffview opened Repo" },
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
