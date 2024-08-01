-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        error("Error cloning lazy.nvim:\n" .. out)
    end
end
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require("lazy").setup({
    -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
    "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

    -- NOTE: Plugins can also be added by using a table,
    -- with the first argument being the link and the following
    -- keys can be used to configure plugin behavior/loading/etc.
    --
    -- Use `opts = {}` to force a plugin to be loaded.
    --

    -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
    --
    -- This is often very useful to both group configuration, as well as handle
    -- lazy loading plugins that don't need to be loaded immediately at startup.
    --
    -- For example, in the following configuration, we use:
    --  event = 'VimEnter'
    --
    -- which loads which-key before all the UI elements are loaded. Events can be
    -- normal autocommands events (`:help autocmd-events`).
    --
    -- Then, because we use the `config` key, the configuration only runs
    -- after the plugin has been loaded:
    --  config = function() ... end

    { -- Useful plugin to show you pending keybinds.
        "folke/which-key.nvim",
        event = "VimEnter", -- Sets the loading event to 'VimEnter'
        opts = {
            icons = {
                rules = false, -- rather not use icons
            },
            layout = {
                width = { min = 20 }, -- min and max width of the columns
                spacing = 3, -- spacing between columns
            },
            keys = {
                scroll_down = "<c-n>", -- binding to scroll down inside the popup
                scroll_up = "<c-p>", -- binding to scroll up inside the popup
            },
        },
        config = function(_, opts)
            -- This is the function that runs, AFTER loading
            require("which-key").setup(opts)

            -- Document existing key chains
            require("which-key").add({
                { "<leader>b", group = "[B]uffer" },
                { "<leader>c", group = "[C]ode" },
                { "<leader>d", group = "[D]ocument" },
                { "<leader>m", group = "[M]ark" },
                { "<leader>j", group = "[J]ump" },
                { "<leader>r", group = "[R]ename" },
                { "<leader>s", group = "[S]earch" },

                { "<leader>w", group = "[W]orkspace/[W]indow" },
                { "<leader>wd", "<cmd>wincmd c<cr>", desc = "Window: [D]elete Current Window" },
                { "<leader>wD", "<cmd>wincmd o<cr>", desc = "Window: [D]elete Other Windows" },
                { "<leader>wh", "<cmd>wincmd h<cr>", desc = "Window: Goto Left Window" },
                { "<leader>wj", "<cmd>wincmd j<cr>", desc = "Window: Goto Down Window" },
                { "<leader>wk", "<cmd>wincmd k<cr>", desc = "Window: Goto Up Window" },
                { "<leader>wl", "<cmd>wincmd l<cr>", desc = "Window: Goto Right Window" },
                { "<leader>ws", "<cmd>sp<cr>", desc = "Window: [S]plit Window" },
                { "<leader>wv", "<cmd>vsp<cr>", desc = "Window: Split Window [V]ertically" },


                { "<leader>t", group = "[T]oggle" },
                { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },

                { "g", group = "Goto" },
                { "s", group = "Surround" },
                { "z", group = "Fold" },

                { "<leader>;", "<cmd>Alpha<cr>", desc = "Alpha" },
                { "<leader>H", "<cmd>nohlsearch<cr>", desc = "Clear [H]ighlights" },
                { "<leader>Q", "<cmd>confirm qall<cr>", desc = "[Q]uit Neovim" },
                { "<leader>S", "<cmd>w!<cr>", desc = "[S]ave file" },
            })
        end,
    },

    -- Nvim-tree is a Neovim plugin to browse the file system
    -- https://github.com/nvim-tree/nvim-tree.lua
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
        },
        keys = {
            { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Nvim: Toggle [E]xplorer" },
        },
        opts = {
            on_attach = function(bufnr)
                local api = require("nvim-tree.api")

                local function opts(desc)
                    return { desc = "nvim-tree:" .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                -- default mappings
                api.config.mappings.default_on_attach(bufnr)
                -- custom mappings
                vim.keymap.set("n", "u", api.tree.change_root_to_parent, opts("Up"))
                vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
                vim.keymap.set("n", "C", api.tree.change_root_to_node, opts("CD"))
                vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
            end,
            update_focused_file = {
                enable = true,
                update_cwd = true,
            },
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                -- width = 30,
                adaptive_size = true,
                side = "left",
            },
            renderer = {
                group_empty = true,
            },
            diagnostics = {
                enable = true,
                show_on_dirs = false,
            },
            filters = {
                dotfiles = true,
            },
        },
        config = function(_, opts)
            -- disable netrw at the very start of your init.lua
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            -- optionally enable 24-bit colour
            vim.opt.termguicolors = vim.g.have_nerd_font

            require("nvim-tree").setup(opts)

            vim.cmd([[
                :hi      NvimTreeExecFile    guifg=#ffa0a0
                :hi      NvimTreeSpecialFile guifg=#ff80ff gui=underline
                :hi      NvimTreeSymlink     guifg=Yellow  gui=italic
                :hi link NvimTreeImageFile   Title
            ]])
        end,
    },

    -- nvim-spectre is a Neovim plugin to replace files
    -- https://github.com/nvim-pack/nvim-spectre
    {
        "nvim-pack/nvim-spectre",
        build = false,
        cmd = "Spectre",
        keys = {
            { "<leader>rN", "<cmd>lua require('spectre').open()<cr>", desc = "Spectre: [R]e[n]ame" },
        },
        opts = { open_cmd = "noswapfile vnew" },
        -- stylua: ignore
    },

    -- alpha is a Neovim plugin to create a dashboard
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        opts = function()
            local dashboard = require("alpha.themes.dashboard")
            -- Set header
            dashboard.section.header.val = {
                [[       /^v^\         |    |    |]],
                [[                    )_)  )_)  )_)     /^v^\]],
                [[          /^v^\    )___))___))___)\     https://github.com/guodongq/dotfiles]],
                [[                  )____)____)_____)\\]],
                [[                _____|____|____|____\\\__]],
                [[                \                   /]],
                [[    ^^^^^ ^^^^^^^^  ^^^^^ ^^^^^  ^^^^^ ^^^^ <><  ]],
                [[      ^^^^  ^^  ^^^    ^ ^^^    ^^^ <>< ^^^^     ]],
                [[       ><> ^^^     ^^    ><> ^^     ^^    ^      ]],
            }
            -- Set menu
            dashboard.section.buttons.val = {
                dashboard.button("f", " " .. " Search Files", ":Telescope find_files<CR>"),
                dashboard.button("g", " " .. " Search by Grep", ":Telescope live_grep <CR>"),
                dashboard.button("p", " " .. " Search Projects", ":Telescope project<CR>"),
                dashboard.button("r", " " .. " Search Recent Files", ":Telescope oldfiles <CR>"),
                dashboard.button("n", " " .. " New File", [[<cmd> ene <BAR> startinsert <cr>]]),
                dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
                dashboard.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <cr>"),
                dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
            }
            for _, button in ipairs(dashboard.section.buttons.val) do
                button.opts.hl = "AlphaButtons"
                button.opts.hl_shortcut = "AlphaShortcut"
            end
            dashboard.section.header.opts.hl = "AlphaHeader"
            dashboard.section.buttons.opts.hl = "AlphaButtons"
            dashboard.section.footer.opts.hl = "AlphaFooter"
            dashboard.opts.layout[1].val = 8
            return dashboard
        end,
        config = function(_, dashboard)
            -- close Lazy and re-open when the dashboard is ready
            if vim.o.filetype == "lazy" then
                vim.cmd.close()
                vim.api.nvim_create_autocmd("User", {
                    once = true,
                    pattern = "AlphaReady",
                    callback = function()
                        require("lazy").show()
                    end,
                })
            end

            -- Set config to alpha
            require("alpha").setup(dashboard.opts)

            vim.api.nvim_create_autocmd("User", {
                once = true,
                pattern = "LazyVimStarted",
                callback = function()
                    local stats = require("lazy").stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    dashboard.section.footer.val = "⚡ Neovim loaded "
                            .. stats.loaded
                            .. "/"
                            .. stats.count
                            .. " plugins in "
                            .. ms
                            .. "ms"
                    pcall(vim.cmd.AlphaRedraw)
                end,
            })

            vim.api.nvim_create_autocmd("User", {
                pattern = "AlphaReady",
                callback = function()
                    vim.cmd([[
               set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
            ]])
                end,
            })
        end,
    },

    -- markdown-preview is a Neovim plugin to preview markdown files
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
        keys = {
            { "<leader>tm", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown: [T]oggle [M]arkdown" },
        },
    },

    -- hop is a Neovim plugin to jump to any location in the visible area
    {
        "smoka7/hop.nvim",
        version = "*",
        event = "VeryLazy",
        keys = {
            { "<leader>j1", "<cmd>HopChar1<cr>", desc = "[J]ump [1] Character", mode = "n" },
            { "<leader>j2", "<cmd>HopChar2<cr>", desc = "[J]ump [2] Characters", mode = "n" },
            { "<leader>jl", "<cmd>HopLine<cr>", desc = "[J]ump [L]ine", mode = "n" },
            { "<leader>jp", "<cmd>HopPattern<cr>", desc = "[J]ump By [P]attern", mode = "n" },
            { "<leader>jw", "<cmd>HopWord<cr>", desc = "[J]ump [W]ord", mode = "n" },
        },
        opts = {
            keys = "etovxqpdygfblzhckisuran",
        },
    },

    -- maximized is a Neovim plugin to maximize the current window
    {
        "0x00-ketsu/maximizer.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            { "<leader>wm", "<cmd>lua require('maximizer').toggle()<cr>", desc = "Window: [M]aximize Current Window" },
        },
    },

    -- nvim-window is a Neovim plugin to pick a window
    {
        "yorickpeterse/nvim-window",
        keys = {
            { "<leader>wp", "<cmd>lua require('nvim-window').pick()<cr>", desc = "Window: [P]ick Window" },
        },
        opts = {
            -- The characters available for hinting windows.
            chars = {
                'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
                'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
            },

            -- A group to use for overwriting the Normal highlight group in the floating
            -- window. This can be used to change the background color.
            normal_hl = 'Normal',

            -- The highlight group to apply to the line that contains the hint characters.
            -- This is used to make them stand out more.
            hint_hl = 'Bold',

            -- The border style to use for the floating window.
            border = 'single',

            -- How the hints should be rendered. The possible values are:
            --
            -- - "float" (default): renders the hints using floating windows
            -- - "status": renders the hints to a string and calls `redrawstatus`,
            --   allowing you to show the hints in a status or winbar line
            render = 'float',
        },
    },

    -- todo-comment is a Neovim plugin to highlight, list, and search TODO comments
    {
        "folke/todo-comments.nvim",
        event = "VimEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = false },
        -- stylua: ignore
        keys = {
            { "<leader>tt", "<cmd>TodoTelescope<cr>", desc = "TODO: [T]oggle [T]odo Comments" },
        },
    },

    -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/plugins/*.lua`
    --    This is the easiest way to modularize your config.
    --
    --  Uncomment the following line and add your plugins to `lua/plugins/*.lua` to get going.
    --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
    { import = "plugins" },
}, {
    rocks = {
        enabled = false,
    },
    ui = {
        -- If you are using a Nerd Font: set icons to an empty table which will use the
        -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
        icons = vim.g.have_nerd_font and {} or {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            require = "🌙",
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤 ",
        },
    },
})
