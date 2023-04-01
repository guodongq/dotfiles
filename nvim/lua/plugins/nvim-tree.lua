-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
--vim.opt.termguicolors = true

local function print_node_path(node)
    print(node.absolute_path)
end

require("nvim-tree").setup({
    hijack_cursor = true,
    sync_root_with_cwd = true,
    update_focused_file = {
        enable = true,
        update_root = true,
        ignore_list = { "help" },
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
    },
    renderer = {
        full_name = true,
        group_empty = true,
        special_files = {},
        symlink_destination = false,
        indent_markers = {
            enable = true,
        },
        icons = {
            git_placement = "signcolumn",
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
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
                -- custom function
                { key = "P", action = "Print Node Path", action_cb = print_node_path },
                -- override existing
                { key = "C", action = "cd" },
                -- new mappings
                { key = "A", action = "expand_all" },
                { key = "?", action = "toggle_help" },
            },
        },
    },
    filters = {
        custom = {
            "^.git$",
        },
    },
})

vim.api.nvim_create_autocmd("BufEnter", {
    nested = true,
    callback = function()
        if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
            vim.cmd "quit"
        end
    end
})
