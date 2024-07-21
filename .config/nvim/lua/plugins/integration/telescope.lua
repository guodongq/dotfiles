local M = {
    "nvim-telescope/telescope.nvim",
    event = "BufEnter",
    cmd = { "Telescope" },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "ahmedkhalf/project.nvim",
        "stevearc/aerial.nvim",
        -- spectre
        {
            "nvim-pack/nvim-spectre",
            build = false,
            cmd = "Spectre",
            opts = { open_cmd = "noswapfile vnew" },
            -- stylua: ignore
        },
    },
    keys = {
        {
            "<leader>sb",
            "<cmd>Telescope current_buffer_fuzzy_find<cr>",
            desc = "Find In Current Buffer",
            mode = "n",
        },
        {
            "<leader>sc",
            "<cmd>Telescope colorscheme<cr>",
            desc = "Colorscheme",
            mode = "n",
        },
        {
            "<leader>sf",
            "<cmd>Telescope find_files<cr>",
            desc = "Find File",
            mode = "n",
        },
        {
            "<leader>sh",
            "<cmd>Telescope help_tags<cr>",
            desc = "Find Help",
            mode = "n",
        },
        {
            "<leader>sp",
            "<cmd>lua require('telescope').extensions.projects.projects{}<cr>",
            desc = "Find Projects",
            mode = "n",
        },
        {
            "<leader>sr",
            "<cmd>Telescope oldfiles<cr>",
            desc = "Find Recent File",
            mode = "n",
        },
        {
            "<leader>sR",
            "<cmd>lua require('spectre').open()<cr>",
            desc = "Replace in Files (Spectre)",
            mode = "n",
        },
        {
            "<leader>ss",
            "<cmd>Telescope<cr>",
            desc = "Find(Telescope)",
            mode = "n",
        },
        {
            "<leader>st",
            "<cmd>Telescope live_grep<cr>",
            desc = "Find Text",
            mode = "n",
        },
    },
}

function M.config()
    -- telescope
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    telescope.setup({
        defaults = {
            prompt_prefix = " ",
            selection_caret = " ",
            path_display = { "smart" },
            file_ignore_patterns = { ".git/", "node_modules" },
            mappings = {
                i = {
                    ["<ESC>"] = actions.close,
                    ["<Down>"] = actions.move_selection_next,
                    ["<Up>"] = actions.move_selection_previous,
                    ["<C-n>"] = actions.move_selection_next,
                    ["<C-p>"] = actions.move_selection_previous,
                },
            },
        },
    })

    -- extensions
    local project = require("project_nvim")
    project.setup({
        -- detection_methods = { "lsp", "pattern" }, -- NOTE: lsp detection will get annoying with multiple langs in one project
        detection_methods = { "pattern" },

        -- patterns used to detect root dir, when **"pattern"** is in detection_methods
        patterns = { ".git", "Makefile", "package.json", "go.mod" },
    })
    telescope.load_extension("projects")
    -- aerial
    telescope.load_extension("aerial")
end

return M
