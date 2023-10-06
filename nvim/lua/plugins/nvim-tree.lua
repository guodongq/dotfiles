local M = {
  "nvim-tree/nvim-tree.lua",
  event = "VimEnter",
}

local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree:" .. desc, buffer = bufnr, noremap= true, silent= true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)
  -- custom mappings
  vim.keymap.set("n", "u", api.tree.change_root_to_parent, opts("Up"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
	vim.keymap.set("n", "C", api.tree.change_root_to_node, opts("CD"))
end

function M.config()
  require("nvim-tree").setup({
    on_attach = on_attach,
    update_focused_file = {
      enable = true,
      update_cwd = true,
    },
    sort_by = "case_sensitive",
    view = {
      width = 30,
      side = "left",
    },
    renderer = {
      icons = {
        glyphs = {
          default = "",
          symlink = "",
          folder = {
            arrow_open = "",
            arrow_closed = "",
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
            symlink_open = "",
          },
          git = {
            unstaged = "",
            staged = "S",
            unmerged = "",
            renamed = "➜",
            untracked = "U",
            deleted = "",
            ignored = "◌",
          },
        },
      },
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
      icons = {
        hint = "󰌵",
        info = "",
        warning = "",
        error = "",
      },
    },
    filters = {
      dotfiles = true,
    },
  })
end

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("NVIM_TREE", { clear = true }),
	pattern = "NvimTree",
	callback = function()
		vim.api.nvim_win_set_option(0, "wrap", false)
	end,
})

return M
