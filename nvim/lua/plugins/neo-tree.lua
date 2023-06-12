-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

require("neo-tree").setup({
  sources = {
    'filesystem',
    'buffers',
    'git_status',
    'document_symbols',
  },
  auto_clean_after_session_restore = true,
  close_if_last_window = true,
  source_selector = {
    winbar = true,
    sources = {
      { source = 'filesystem', display_name = ' 󰉓  Files ' },
      { source = 'git_status', display_name = ' 󰊢  Git ' },
      { source = 'buffers', display_name = ' 󰗚  Buffers ' },
      { source = 'document_symbols', display_name = '   Symbols ' },
    },
  },
  window = {
    position = 'float',
    mappings = {
      ["o"] = "open",
			["<space>"] = {
                "toggle_node",
                nowait = true, -- disable `nowait` if you have existing combos starting with this char that you want to use
            },
    },
  },
  filesystem = {
    follow_current_file = true,
    hijack_netrw_behavior = 'open_current',
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_by_name = {
        'node_modules',
      },
      never_show = {
        '.DS_Store',
        'thumbs.db',
      },
    },
  },
  default_component_configs = {
    icon = {
      folder_empty = '󰜌',
      folder_empty_open = '󰜌',
    },
    git_status = {
      symbols = {
        renamed = '󰁕',
        unstaged = '󰄱',
      },
    },
  },
  document_symbols = {
    kinds = {
      File = { icon = '󰈙', hl = 'Tag' },
      Namespace = { icon = '󰌗', hl = 'Include' },
      Package = { icon = '󰏖', hl = 'Label' },
      Class = { icon = '󰌗', hl = 'Include' },
      Property = { icon = '󰆧', hl = '@property' },
      Enum = { icon = '󰒻', hl = '@number' },
      Function = { icon = '󰊕', hl = 'Function' },
      String = { icon = '󰀬', hl = 'String' },
      Number = { icon = '󰎠', hl = 'Number' },
      Array = { icon = '󰅪', hl = 'Type' },
      Object = { icon = '󰅩', hl = 'Type' },
      Key = { icon = '󰌋', hl = '' },
      Struct = { icon = '󰌗', hl = 'Type' },
      Operator = { icon = '󰆕', hl = 'Operator' },
      TypeParameter = { icon = '󰊄', hl = 'Type' },
      StaticMethod = { icon = '󰠄 ', hl = 'Function' },
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
