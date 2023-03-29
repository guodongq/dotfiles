-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
--vim.opt.termguicolors = true

require("nvim-tree").setup({
    auto_reload_on_write = true,
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    sort_by = "case_sensitive",
    update_focused_file = {
        enable = true,
        update_root = true,
    },
    view = {
        adaptive_size = true,
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
    renderer = {
        group_empty = true,
        icons = {
            glyphs = {
                git = {
                    unstaged = "",
                    staged = "",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "",
                    deleted = "",
                    ignored = "◌",
                },
            },
        },
    },
    filters = {
        dotfiles = true,
    },
})

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('NVIM_TREE', { clear = true }),
    pattern = 'NvimTree',
    callback = function()
        vim.api.nvim_win_set_option(0, 'wrap', false)
    end,
})
