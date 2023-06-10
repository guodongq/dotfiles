-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

require("neo-tree").setup({
  follow_current_file = true, -- This will find and focus the file in the active buffer every
  window = {
    mappings = {
      ["o"] = "open",
			["<space>"] = {
                "toggle_node",
                nowait = true, -- disable `nowait` if you have existing combos starting with this char that you want to use
            },
    },
  },

  event_handlers = {
    -- Auto Close on Open File
    -- {
    --       event = "file_opened",
    --       handler = function(file_path)
    --       --auto close
    --      require("neo-tree").close_all()
    --    end
    --  },
    -- hide cursor in neo-tree window
    {
        event = "neo_tree_buffer_enter",
        handler = function()
          -- This effectively hides the cursor
          vim.cmd 'highlight! Cursor blend=100'
        end
      },
      {
        event = "neo_tree_buffer_leave",
        handler = function()
          -- Make this whatever your current Cursor highlight group is.
          vim.cmd 'highlight! Cursor guibg=#5f87af blend=0'
        end
      }
   },
})

vim.cmd([[nnoremap \ :Neotree toggle reveal<cr>]])
