-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup({
    sort_by = "case_sensitive",
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    renderer = {
        root_folder_modifier = ":t",
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    view = {
        adaptive_size = true,
        -- width = 25,
        side = "left",
        mappings = {
            list = {
                { key = "u", action = "dir_up" },
                { key = "O", action = "system_open" },
                { key = { "l", "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
                { key = "v", action = "vsplit" },
                { key = "h", action = "close_node" },
                { key = "s", action = "split" },
                { key = "<S-c>", action = "cd" },
            },
        },
    },
    filters = {
        custom = { '.git$', 'node_modules$', '^target$' },

    }
})

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('NVIM_TREE', { clear = true }),
    pattern = 'NvimTree',
    callback = function()
        vim.api.nvim_win_set_option(0, 'wrap', false)
    end,
})

-- 自动关闭
vim.cmd([[
    autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
]])
