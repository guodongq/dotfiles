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



        -- todo
        ["<leader>t"] = { name = "Todo" },
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