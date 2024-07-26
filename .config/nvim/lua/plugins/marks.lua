local M = {
    "LintaoAmons/bookmarks.nvim",
    -- tag = "v0.5.4", -- optional, pin the plugin at specific version for stability
    dependencies = {
        { "nvim-telescope/telescope.nvim" },
        { "stevearc/dressing.nvim" } -- optional: to have the same UI shown in the GIF
    }
}

M.keys = {
    {
        "<leader>mm",
        "<cmd>BookmarksMark<cr>",
        desc = "Mark current line into active BookmarkList",
        mode = { "n", "v" },
    },
    {
        "<leader>mo",
        "<cmd>BookmarksGoto<cr>",
        desc = "Go to bookmark at current active BookmarkList",
        mode = { "n", "v" },
    },
    {
        "<leader>ma",
        "<cmd>BookmarksCommands<cr>",
        desc = "Find and trigger a bookmark command.",
        mode = { "n", "v" },
    },
    {
        "<leader>mg",
        "<cmd>BookmarksGotoRecent<cr>",
        desc = "Go to latest visited/created Bookmark",
        mode = { "n", "v" },
    },
}

function M.config()
    require("bookmarks").setup({
        json_db_path = vim.fs.normalize(vim.fn.stdpath("config") .. "/bookmarks.db.json"),
        signs = {
            mark = { icon = "", color = "grey" },
        },
        hooks = {
            {
                ---a sample hook that change the working directory when goto bookmark
                ---@param bookmark Bookmarks.Bookmark
                ---@param projects Bookmarks.Project[]
                callback = function(bookmark, projects)
                    local project_path
                    for _, p in ipairs(projects) do
                        if p.name == bookmark.location.project_name then
                            project_path = p.path
                        end
                    end
                    if project_path then
                        vim.cmd("cd " .. project_path)
                    end
                end,
            },
        },
    })
end

return M