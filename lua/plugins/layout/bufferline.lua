require("bufferline").setup {
    options = {
        view = "multiwindow",
        numbers = function(opts)
            return string.format("%s|%s", opts.lower(opts.ordinal), opts.raise(opts.id))
        end,
        tab_size = 18,
        show_buffer_close_icons = false,
        diagnostics = "nvim_lsp",
        separator_style = "thick", -- thin, thick
        enforce_regular_tabs = true,
        offsets = {
            {
                text = 'FILE EXPLORER',
                filetype = 'NvimTree',
                highlight = 'PanelHeading',
                text_align = 'left',
                separator = true,
            },
            {
                text = ' SYMBOLS OUTLINE',
                filetype = 'Outline',
                highlight = 'PanelHeading',
                separator = true,
            },
            {
                text = 'UNDOTREE',
                filetype = 'undotree',
                highlight = 'PanelHeading',
                separator = true,
            },
            {
                text = ' PACKER',
                filetype = 'packer',
                highlight = 'PanelHeading',
                separator = true,
            },
            {
                text = ' DATABASE VIEWER',
                filetype = 'dbui',
                highlight = 'PanelHeading',
                separator = true,
            },
            {
                text = ' DIFF VIEW',
                filetype = 'DiffviewFiles',
                highlight = 'PanelHeading',
                separator = true,
            },
        }
    },
}

for i = 1, 9 do
    vim.keymap.set("n", "<leader>" .. i, "<cmd>BufferLineGoToBuffer " .. i .. "<CR>", { silent = true })
end
