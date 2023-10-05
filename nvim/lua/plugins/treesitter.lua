return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/playground", -- show treesitter nodes
            "nvim-treesitter/nvim-treesitter-textobjects", -- enable more advanced treesitter-aware text objects
            "JoosepAlviste/nvim-ts-context-commentstring"
        },
        opts = {
            ensure_installed = {
                "bash",
                "c",
                "diff",
                "comment",
                "git_rebase",
                "gitcommit",
                "gitignore",
                "html",
                "json",
                "markdown",
                "markdown_inline",
                "vim",
                "yaml",
                "javascript",
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm",
                },
            },
            highlight = { enable = true, use_languagetree = true },
            context_commentstring = { enable = true },
            indent = { enable = true },
            rainbow = { enable = true, extended_mode = true, max_file_lines = 1000},
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                    },
                },
                swap = {
                    enable = false,
                    swap_next = { ["<leader>a"] = "@parameter.inner" },
                    swap_previous = { ["<leader>A"] = "@parameter.inner" },
                },
            },
            playground = {
                enable = true,
                disable = {},
                updatetime = 25,
                persist_queries = false,
                keybindings = {
                    toggle_query_editor = "o",
                    toggle_hl_groups = "i",
                    toggle_injected_languages = "t",
                    toggle_anonymous_node = "a",
                    toggle_language_display = "I",
                    focus_language = "f",
                    unfocus_language = "F",
                    update = "R",
                    goto_node = "<cr>",
                    show_help = "?",
                },
            },
        },
    },
}
