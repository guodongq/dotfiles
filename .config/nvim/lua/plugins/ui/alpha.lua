local M = {
    "goolord/alpha-nvim",
    event = "VimEnter",
}

function M.opts()
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
        dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
        dashboard.button("f", " " .. " Find file", ":Telescope find_files<CR>"),
        dashboard.button("w", " " .. " Find word", ":Telescope live_grep <CR>"),
        dashboard.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <cr>"),
        dashboard.button("n", " " .. " New file", [[<cmd> ene <BAR> startinsert <cr>]]),
        dashboard.button("p", " " .. " Find project", ":Telescope projects<CR>"),
        dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
        dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
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
end

function M.config(_, dashboard)
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
end

return M
