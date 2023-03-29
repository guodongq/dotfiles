local alpha = require('alpha')
local dashboard = require("alpha.themes.dashboard")

-- dashboard.section.header.val = {
--     [[                               __                ]],
--     [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
--     [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
--     [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
--     [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
--     [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
-- }

dashboard.section.buttons.val = {
    dashboard.button("SPC s f", "  Find file", ":Telescope find_files <CR>"),
    dashboard.button("SPC s e", "  New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("SPC s p", "  Find project", ":Telescope project <CR>"),
    dashboard.button("SPC s r", "  Recently used files", ":Telescope oldfiles <CR>"),
    dashboard.button("SPC s t", "  Find text", ":Telescope live_grep <CR>"),
    dashboard.button("SPC e", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
    dashboard.button("SPC q q", "  Quit Neovim", ":qa<CR>"),
}

local function footer()
    -- NOTE: requires the fortune-mod package to work
    -- local handle = io.popen("fortune")
    -- local fortune = handle:read("*a")
    -- handle:close()
    -- return fortune
    --return "qgd365@126.com"
    return ""
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
-- alpha.setup(dashboard.opts)


-- startify 
local startify = require('alpha.themes.startify')

alpha.setup(startify.config)

