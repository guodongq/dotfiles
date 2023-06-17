-- Add any additional keymaps here
local wk = require('which-key')

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
    normal_mode = {
        -- Buffers
        ["<leader>ba"] = { "<cmd>lua require('Buffers').clear()<cr>", "Close all buffers" },
        ["<leader>bd"] = { "<cmd>lua require('Buffers').delete()<cr>", "Kill current buffer" },
        ["<leader>bD"] = { "<cmd>lua require('Buffers').only()<cr>", "Kill other buffers" },
        ["<leader>bl"] = { "<cmd>Telescope buffers path_display={'truncate'}<cr>", "List buffers" },
        ["<leader>bn"] = { "<cmd>bn<cr>", "Next buffer" },
        ["<leader>bp"] = { "<cmd>bp<cr>", "Previous buffer" },
        ["<S-l>"] = { "<cmd>bn<cr>", "Next buffer" },
        ["<S-h>"] = { "<cmd>bp<cr>", "Previous buffer" },

        -- Compile/Comments
        ["<leader>cb"] = { "<cmd>lua require('Comment.api').toggle.blockwise.current()<cr>", "comment-or-uncomment-blocks" },
        ["<leader>co"] = { "<cmd>lua require('Comment.api').insert.linewise.below()<cr>", "comment-line-below" },
        ["<leader>cO"] = { "<cmd>lua require('Comment.api').insert.linewise.above()<cr>", "comment-line-above" },
        ["<leader>c/"] = { "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>", "comment-or-uncomment-lines" },
        ["<leader>c$"] = { "<cmd>lua require('Comment.api').insert.linewise.eol()<cr>", "comment-end-of-line" },

        -- Debug
        ["<leader>db"] = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "toggle breakpoint" },
        ["<leader>dl"] = { "<cmd>Telescope dap list_breakpoints<cr>", "show all breakpoints" },
        ["<leader>dx"] = { "<cmd>lua require('dap').clear_breakpoints()<cr>", "removes all breakpoints" },
        ["<leader>du"] = { "<cmd>lua require('dapui').toggle()<cr>", "toggle dapui" },
        ["<leader>dq"] = { "<cmd>lua require('dap').terminate()<cr>", "terminate" },


        -- Files
        ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find files" },
        ["<leader>fs"] = { "<cmd>w!<cr>", "Save a file" },
        ["<leader>ft"] = { "<cmd>Neotree toggle filesystem<cr>", "File tree" },
        ["<leader>fT"] = { "<cmd>Neotree focus filesystem reveal<cr>", "Focus current file in file tree" },

        -- Git
        ["<leader>gd"] = { "<cmd>DiffviewOpen<cr>", "Diffview opene" },
        ["<leader>gD"] = { "<cmd>DiffviewClose<cr>", "Diffview close" },
        ["<leader>gm"] = { "<cmd>GitMessenger<cr>", "Reveal commit messages" },
        ["<leader>gh"] = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff this HEAD" },

        -- Help
        ["<leader>hr"] = { "<cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><cr>", "Redraw/Clear hlsearch/Diff update" }, -- Clear search, diff update and redraw, taken from runtime/lua/_editor.lua

        -- Jump/Join/Split
        ["<leader>j1"] = { "<cmd>HopChar1<cr>", "jump-or-select-to-a-character" },
        ["<leader>j2"] = { "<cmd>HopChar2<cr>", "jump-to-suite-of-two-characters" },
        ["<leader>jl"] = { "<cmd>HopLine<cr>", "jump-or-select-to-a-line" },
        ["<leader>jp"] = { "<cmd>HopPattern<cr>", "jump-or-select-to-a-pattern" },
        ["<leader>jw"] = { "<cmd>HopWord<cr>", "jump-to-a-word" },

        -- LSP
        ["<leader>lm"] = { "<cmd>Mason<cr>", "Mason" },
        ["<leader>lr"] = { "<cmd>lua require('spectre').open()<cr>", "Replace in files (Spectre)" },
        ["<leader>lo"] = { "<cmd>SymbolsOutline<cr>", "SymbolsOutline" },

        -- Quit
        ["<leader>qq"] = { "<esc><cmd>qa<cr>", "Quit neovim" },

        -- Search/Symbol
        ["<leader>sb"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search in current buffer" },
        ["<leader>sf"] = { "<cmd>Telescope find_files<cr>", "Search files (root dir)" },
        ["<leader>sg"] = { "<cmd>Telescope live_grep<cr>", "Search grep" },
        ["<leader>sp"] = { "<cmd>lua require('telescope').extensions.projects.projects{}<cr>", "Search project" },
        ["<leader>sr"] = { "<cmd>Telescope oldfiles<cr>", "Search recent" },
        ["<leader>st"] = { "<cmd>Telescope<cr>", "Search (Telescope)" },

        -- Todo/Terminal


        -- Windows
        ["<leader>wc"] = { "<cmd>lua require('nvim-window').pick()<cr>", "Choose a window" },
        ["<leader>wd"] = { "<cmd>wincmd c<cr>", "Close current window" },
        ["<leader>wD"] = { "<cmd>wincmd o<cr>", "Close other windows" },
        ["<leader>wh"] = { "<cmd>wincmd h<cr>", "Go to the left window" },
        ["<leader>wj"] = { "<cmd>wincmd j<cr>", "Go to the down window" },
        ["<leader>wk"] = { "<cmd>wincmd k<cr>", "Go to the up window" },
        ["<leader>wl"] = { "<cmd>wincmd l<cr>", "Go to the right window" },
        ["<leader>wm"] = { "<cmd>lua require('maximizer').toggle()<cr>", "Maximize current window" },
        ["<leader>ws"] = { "<cmd>sp<cr>", "Split window" },
        ["<leader>wv"] = { "<cmd>vsp<cr>", "Split window vertically" },
    }
}

for mode, keys in pairs(mappings) do
    local mode_adapter = mode_adapters[mode]
    wk.register(keys, { mode = mode_adapter })
end


