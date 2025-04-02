return {
    { -- Terminal
        "akinsho/toggleterm.nvim",
        version = "*",
        enabled = true,
        event = "VeryLazy",
        opts = {
            size = 20,
            open_mapping = [[<c-\>]],
            hide_numbers = true,
            shade_terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,
            direction = "float", -- float, horizontal
            close_on_exit = true,
            shell = vim.o.shell,
            float_opts = {
                border = "curved",
            },
        },
        config = function(_, opt)
            require("toggleterm").setup(opt)

            function _G.set_terminal_keymaps()
                local opts = { noremap = true }
                vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
                vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
                vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<cmd>wincmd h<cr>]], opts)
                vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<cmd>wincmd j<cr>]], opts)
                vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<cmd>wincmd k<cr>]], opts)
                vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<cmd>wincmd l<cr>]], opts)
                vim.api.nvim_buf_set_keymap(0, "t", "<C-w>", [[<C-\><C-n><C-W>]], opts)
            end

            vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

            local Terminal = require("toggleterm.terminal").Terminal
            local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

            function _LAZYGIT_TOGGLE()
                lazygit:toggle()
            end
        end,
    },
    { -- Useful plugin to show you pending keybinds.
        "folke/which-key.nvim",
        event = "VimEnter", -- Sets the loading event to 'VimEnter'
        opts = {
            delay = 0,
            icons = {
                -- set icon mappings to true if you have a Nerd Font
                mappings = false, --vim.g.have_nerd_font,
                -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
                -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
                keys = vim.g.have_nerd_font and {} or {
                    Up = "<Up> ",
                    Down = "<Down> ",
                    Left = "<Left> ",
                    Right = "<Right> ",
                    C = "<C-…> ",
                    M = "<M-…> ",
                    D = "<D-…> ",
                    S = "<S-…> ",
                    CR = "<CR> ",
                    Esc = "<Esc> ",
                    ScrollWheelDown = "<ScrollWheelDown> ",
                    ScrollWheelUp = "<ScrollWheelUp> ",
                    NL = "<NL> ",
                    BS = "<BS> ",
                    Space = "<Space> ",
                    Tab = "<Tab> ",
                    F1 = "<F1>",
                    F2 = "<F2>",
                    F3 = "<F3>",
                    F4 = "<F4>",
                    F5 = "<F5>",
                    F6 = "<F6>",
                    F7 = "<F7>",
                    F8 = "<F8>",
                    F9 = "<F9>",
                    F10 = "<F10>",
                    F11 = "<F11>",
                    F12 = "<F12>",
                },
            },

            -- Document existing key chains
            spec = {
                { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
                { "<leader>d", group = "[D]ocument" },
                { "<leader>r", group = "[R]ename" },
                { "<leader>s", group = "[S]earch" },
                { "<leader>w", group = "[W]orkspace" },
                { "<leader>t", group = "[T]oggle" },
                { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },

                { "<leader>b", group = "[B]uffer" },
                { "<leader>j", group = "[J]ump" },

                { "g", group = "[G]oto" },
                { "s", group = "[S]urround" },
                { "z", group = "Fold" },

                { "<leader>H", "<cmd>nohlsearch<cr>", desc = "Clear [H]ighlights" },
                { "<leader>Q", "<cmd>confirm qall<cr>", desc = "[Q]uit Neovim" },
                { "<leader>S", "<cmd>w!<cr>", desc = "[S]ave file" },
            },
        },
    },
}