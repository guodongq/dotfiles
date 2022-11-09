require('nvim-autopairs').setup({
    check_ts = true,
    ts_config = {
        lua = { "string", "comment" },
    },
    disable_filetype = { "TelescopePrompt", "spectre_panel", "dap-repl", "guihua", "guihua_rust", "clap_input" },
    fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0, -- Offset from pattern match
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
    },
})

-- Integration w/ nvim-cmp
require('cmp').event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())
