-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand:
vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('PACKER', { clear = true }),
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerCompile',
})

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    ---------------------
    -- Package Manager --
    ---------------------

    use('wbthomason/packer.nvim')

    ----------------------
    -- Required plugins --
    ----------------------

    use('nvim-lua/plenary.nvim')

    -----------------------------------
    -- Tools --
    -----------------------------------

    use({
        'goolord/alpha-nvim',
        event = 'VimEnter',
        config = function()
            require("plugins.dashboard")
        end,
    })

    use({
        'eduardomillans/maximizer.nvim',
        config = function()
            require('plugins.maximizer')
        end,
        event = 'VimEnter',
    })

    use({
        'yorickpeterse/nvim-window',
        config = function()
            require('plugins.nvim-window')
        end,
        event = 'VimEnter',
    })

    use({
        'folke/trouble.nvim',
        requires = 'nvim-tree/nvim-web-devicons',
        config = function()
            require('trouble').setup()
        end
    })

    use({
        'folke/which-key.nvim',
        event = 'VimEnter',
        config = function()
            require('plugins.which-key')
        end,
    })

    ----------------------------------------
    -- Theme, Icons, Statusbar, Bufferbar --
    ----------------------------------------
    use({
        'kyazdani42/nvim-web-devicons',
        config = function()
            require('nvim-web-devicons').setup()
        end,
    })

    -- Colorscheme
    use({
      'folke/tokyonight.nvim',
      config = function()
        require('plugins.colorscheme')
      end,
    })

    use({
      'Mofiqul/dracula.nvim',
      config = function()
        require('plugins.colorscheme')
      end,
    })

    use({
      'ellisonleao/gruvbox.nvim',
      config = function()
        require('plugins.colorscheme')
      end,
    })

    use({
        'numToStr/Sakura.nvim',
        config = function()
            require('plugins.colorscheme')
        end,
    })

    use({
        'nvim-lualine/lualine.nvim',
        -- after = 'Sakura.nvim',
        -- after = 'dracula.nvim',
        -- after = 'gruvbox.nvim',
        after = 'tokyonight.nvim',
        event = 'BufEnter',
        config = function()
            require('plugins.lualine')
        end,
    })

    -----------------------------------
    -- Treesitter: Better Highlights --
    -----------------------------------

    use({
        {
            'nvim-treesitter/nvim-treesitter',
            event = 'CursorHold',
            run = ':TSUpdate',
            config = function()
                require('plugins.treesitter')
            end,
        },
        { 'nvim-treesitter/playground', after = 'nvim-treesitter' },
        { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
        { 'nvim-treesitter/nvim-treesitter-refactor', after = 'nvim-treesitter' },
        { 'windwp/nvim-ts-autotag', after = 'nvim-treesitter' },
        { 'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter' },
    })

    use({
        'folke/todo-comments.nvim',
        after = 'nvim-treesitter',
        event = 'BufReadPost',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('todo-comments').setup()
        end,
    })

    --------------------------
    -- Editor UI Niceties --
    --------------------------

    use({
        'lukas-reineke/indent-blankline.nvim',
        event = 'BufRead',
        config = function()
            require('plugins.indentline')
        end,
    })

    use({
        'norcalli/nvim-colorizer.lua',
        event = 'CursorHold',
        config = function()
            require('colorizer').setup()
        end,
    })

    ---------------
    -- Git Stuff --
    ---------------

    use({
        'lewis6991/gitsigns.nvim',
        event = 'BufRead',
        config = function()
            require('plugins.gitsigns')
        end,
    })

    use({
        'rhysd/git-messenger.vim',
        event = 'BufRead',
        config = function()
            vim.g.git_messenger_no_default_mappings = true
            --vim.keymap.set('n', '<leader>gm', '<CMD>GitMessenger<CR>')
        end,
    })

    use({
        'sindrets/diffview.nvim',
        event = 'BufRead',
        config = function()
            require('plugins.diffview')
        end,
    })

    ---------------------------------
    -- Navigation and Fuzzy Search --
    ---------------------------------

     use({
        'nvim-neo-tree/neo-tree.nvim',
        branch = "v2.x",
        event = 'CursorHold',
        requires = {
          'nvim-lua/plenary.nvim',
          'nvim-tree/nvim-web-devicons',
          'MunifTanjim/nui.nvim',
          {
            -- only needed if you want to use the commands with "_with_window_picker" suffix
            's1n7ax/nvim-window-picker',
            tag = "v1.*",
            config = function()
              require'window-picker'.setup({
                autoselect_one = true,
                include_current = false,
                filter_rules = {
                  -- filter using buffer options
                  bo = {
                    -- if the file type is one of following, the window will be ignored
                    filetype = { 'neo-tree', "neo-tree-popup", "notify" },

                    -- if the buffer type is one of following, the window will be ignored
                    buftype = { 'terminal', "quickfix" },
                  },
                },
                other_win_hl_color = '#e35e4f',
              })
            end,
          }
        },
        config = function()
          require('plugins.neo-tree')
        end,
      })

        use({
        {
            'nvim-telescope/telescope.nvim',
            event = 'CursorHold',
            config = function()
                require('plugins.telescope')
            end,
        },
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            after = 'telescope.nvim',
            run = 'make',
            config = function()
                require('telescope').load_extension('fzf')
            end,
        },
        {
            'nvim-telescope/telescope-symbols.nvim',
            after = 'telescope.nvim',
        },
        {
            'ahmedkhalf/project.nvim',
            after = 'telescope.nvim',
            config = function()
                require('project_nvim').setup()
                require('telescope').load_extension('projects')
            end
        },
        {
            'nvim-telescope/telescope-dap.nvim',
            after = { 'telescope.nvim', 'nvim-dap' },
            config = function()
                require('telescope').load_extension('dap')
            end
        }
    })

    use({
        'phaazon/hop.nvim',
        event = 'BufRead',
        config = function()
            require('hop').setup()
        end,
    })

    use({
        'karb94/neoscroll.nvim',
        event = 'WinScrolled',
        config = function()
            require('neoscroll').setup({ hide_cursor = false })
        end,
    })

  -- markdown
    use({
      'iamcco/markdown-preview.nvim',
      run = function() vim.fn['mkdp#util#install']() end,
    })

    -------------------------
    -- Editing to the MOON --
    -------------------------

    use({
        'numToStr/Comment.nvim',
        event = 'BufRead',
        config = function()
            require("Comment").setup()
        end,
    })

    use({
        'numToStr/Buffers.nvim',
        event = 'BufRead',
        config = function()
            --vim.keymap.set('n', '<leader>bd', '<CMD>lua require("Buffers").delete()<CR>')
            --vim.keymap.set('n', '<leader>bD', '<CMD>lua require("Buffers").only()<CR>')
            --vim.keymap.set('n', '<leader>ba', '<CMD>lua require("Buffers").clear()<CR>')
        end,
    })

    -- replace symbols
    use({
        'nvim-pack/nvim-spectre',
        event = 'BufReadPost',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('spectre').setup({})
        end,
    })

    --------------
    -- Terminal --
    --------------

    use({
        'akinsho/toggleterm.nvim',
        tag = '*',
        event = 'CursorHold',
        config = function()
            require('plugins.toggleterm')
        end,
    })

    -----------------------------------
    -- LSP, Completions and Snippets --
    -----------------------------------
    use {
        'VonHeikemen/lsp-zero.nvim',
        config = function()
            require('plugins.lsp')
        end,
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            { 
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            }, -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' }, -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'hrsh7th/cmp-buffer' }, -- Optional
            { 'hrsh7th/cmp-path' }, -- Optional
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional
            { 'hrsh7th/cmp-nvim-lua' }, -- Optional

            -- Snippets
            { 'L3MON4D3/LuaSnip' }, -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional
        }
    }

    use({
        'simrat39/symbols-outline.nvim',
        config = function()
            require('symbols-outline').setup({
                show_numbers = true,
            })
        end,
    })

    use({
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            require('plugins.null-ls')
        end,
    })

    -- NOTE: nvim-autopairs needs to be loaded after nvim-cmp, so that <CR> would work properly
    use({
        'windwp/nvim-autopairs',
        event = 'InsertCharPre',
        after = 'nvim-cmp',
        config = function()
            require('plugins.pairs')
        end,
    })

    use({
        'j-hui/fidget.nvim',
        tag = 'legacy',
        config = function()
            require('fidget').setup()
        end,
    })

    -----------------------------------
    -- Debugger --
    -----------------------------------

    use({
        {
            'mfussenegger/nvim-dap',
            event = 'CursorHold',
            config = function()
                require('plugins.dap')
            end,
        },
        {
            'theHamsta/nvim-dap-virtual-text',
            after = { 'nvim-dap', 'nvim-treesitter' },
            config = function()
                require("nvim-dap-virtual-text").setup()
            end,
        },
        {
            'rcarriga/nvim-dap-ui',
            after = { 'nvim-dap' },
            config = function()
                require("dapui").setup()

                local dap, dapui = require("dap"), require("dapui")
                dap.listeners.after.event_initialized["dapui_config"] = function()
                    dapui.open()
                end
                dap.listeners.before.event_terminated["dapui_config"] = function()
                    dapui.close()
                end
                dap.listeners.before.event_exited["dapui_config"] = function()
                    dapui.close()
                end
            end,
        }
    })


    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
