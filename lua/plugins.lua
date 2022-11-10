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
    use({
	 'wbthomason/packer.nvim',
	 commit = '14571611c06e757f4f5fe46b82657417645c74dc',
    })
    use('nvim-lua/plenary.nvim')


    ----------------------------------------
    -- Theme, Icons, Statusbar, Bufferbar --
    ----------------------------------------
    use({
        'kyazdani42/nvim-web-devicons',
        config = function ()
            require('nvim-web-devicons').setup()
        end,
    })

    use({
        'folke/tokyonight.nvim',
        config = function ()
            require('plugins.theme')
        end,
    })

    use({
        {
            'nvim-lualine/lualine.nvim',
            after = 'tokyonight.nvim',
            event = 'BufEnter',
            config = function()
                require('plugins.layout.lualine')
            end,
        },
        {
            'j-hui/fidget.nvim',
            after = 'lualine.nvim',
            config = function()
                require('fidget').setup()
            end,
        },
    })

    use {
        'akinsho/nvim-bufferline.lua',
        event = 'BufRead',
        config = function()
            require('plugins.layout.bufferline')
        end,
        requires = {
            { 'moll/vim-bbye' },
        }
    }

    use {
        'eduardomillans/maximizer.nvim',
        config = function()
            require('plugins.layout.maximizer')
        end,
        event = 'VimEnter',
    }

    use {
        'kowsmo7/window-picker.nvim',
        config = function()
            require('plugins.layout.window-picker')
        end,
        event = 'VimEnter',
    }

    -----------------------------------
    -- Treesitter: Better Highlights --
    -----------------------------------
    use({
        {
            'nvim-treesitter/nvim-treesitter',
            event = 'CursorHold',
            run = ':TSUpdate',
            config = function ()
                require('plugins.helper.treesitter')
            end,
        },
        { 'nvim-treesitter/playground', after = 'nvim-treesitter' },
        { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
        { 'nvim-treesitter/nvim-treesitter-refactor', after = 'nvim-treesitter' },
        { 'windwp/nvim-ts-autotag', after = 'nvim-treesitter' },
        { 'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter' },
    })

    --------------------------
    -- Editor UI Niceties --
    --------------------------

    use {
        'lukas-reineke/indent-blankline.nvim',
        event = 'BufRead',
        config = function()
            require('plugins.editor.indentline')
        end
    }

    use({
        'norcalli/nvim-colorizer.lua',
        event = 'CursorHold',
        config = function()
            require('colorizer').setup()
        end,
    })


    use {
        'lewis6991/gitsigns.nvim',
        event = 'BufRead',
        config = function()
            require('plugins.editor.gitsigns')
        end,
    }

    ---------------------------------
    -- Navigation and Fuzzy Search --
    ---------------------------------

    use({
        'kyazdani42/nvim-tree.lua',
        event = 'CursorHold',
        config = function()
            require('plugins.layout.nvim-tree')
        end,
    })


    use({
        {
            'nvim-telescope/telescope.nvim',
            event = 'CursorHold',
            config = function()
                require('plugins.helper.telescope')
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
            config = function ()
                require('project_nvim').setup({
                    detection_methods = { "lsp", "pattern" },
                    patterns = { ".git", "go.mod", "Makefile", "package.json" },
                })
                require('telescope').load_extension('projects')
            end,
        },
    })


    use({
        'phaazon/hop.nvim',
        event = 'BufRead',
        config = function()
            require('plugins.editor.hop')
        end,
    })

    use({
        'karb94/neoscroll.nvim',
        event = 'WinScrolled',
        config = function()
            require('neoscroll').setup({ hide_cursor = false })
        end,
    })



    ----------------------------------------
    -- Helper, Tools --
    ----------------------------------------

    use {
        'folke/which-key.nvim',
        config = function()
            require('plugins.helper.which-key')
        end,
    }

    use {
        'goolord/alpha-nvim',
        config = function()
            require('plugins.helper.alpha')
            -- require'alpha'.setup(require'alpha.themes.dashboard'.config)
        end,
    }

    use {
        'akinsho/toggleterm.nvim',
        tag = '*',
        event = 'CursorHold',
        config = function()
            require('plugins.helper.toggleterm')
        end
    }

    use {
        'folke/trouble.nvim',
        event = 'BufReadPre',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('trouble').setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
                auto_open = false,
                use_diagnostic_signs = true,
            }
        end
    }

    use {
        'folke/todo-comments.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('todo-comments').setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }

    ----------------------------------------
    -- Editor --
    ----------------------------------------

    use({
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    })

    use {
        'nvim-neorg/neorg',
        config = function()
            require('neorg').setup()
        end,
        requires = 'nvim-lua/plenary.nvim'
    }


    -----------------------------------
    -- LSP, Completions and Snippets --
    -----------------------------------

    use({
        'williamboman/mason.nvim',
        config = function()
            require('plugins.completion.mason')
        end,
        requires = {
            'williamboman/mason-lspconfig.nvim',
        }
    })

    use({
        'neovim/nvim-lspconfig',
        event = 'BufRead',
        config = function()
            require('plugins.completion.lsp')
        end,
        requires = {
            {
                -- WARN: Unfortunately we won't be able to lazy load this
                'hrsh7th/cmp-nvim-lsp',
            },
        },
    })

    use({
        'jose-elias-alvarez/null-ls.nvim',
        event = 'BufRead',
        config = function()
            require('plugins.completion.null-ls')
        end,
    })

    use({
        'simrat39/symbols-outline.nvim',
        commit = '8cf5a283a2404100824c1a52abee8fcafbd654d3',
        config = function()
            require('symbols-outline').setup()
        end,
        after = 'nvim-lspconfig',
    })

    use({
        {
            'hrsh7th/nvim-cmp',
            event = 'CursorHold',
            config = function()
                require('plugins.completion.cmp')
            end,
            requires = {
                {
                    'L3MON4D3/LuaSnip',
                    -- event = 'CursorHold',
                    config = function()
                        require('plugins.completion.luasnip')
                    end,
                    requires = {
                        {
                            'rafamadriz/friendly-snippets',
                            -- event = 'CursorHold',
                        },
                    },
                },
            },
        },
        { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
    })

    -- NOTE: nvim-autopairs needs to be loaded after nvim-cmp, so that <CR> would work properly
    use({
        'windwp/nvim-autopairs',
        event = 'InsertCharPre',
        after = 'nvim-cmp',
        config = function()
            require('plugins.completion.pairs')
        end,
    })

    -- Markdown
    use({
        { 'mzlogin/vim-markdown-toc' },
        { 
            'iamcco/markdown-preview.nvim',
            run = function()
                vim.fn['mkdp#util#install']()
            end,
            ft = {'markdown'},
        },
        { 'dhruvasagar/vim-table-mode' },
    })


    -----------------------------------
    -- Debugs --
    -----------------------------------
    --use({
    --    {
    --        'rcarriga/nvim-dap-ui',
    --        config = function()
    --            require('plugins.debug.dap')
    --        end,
    --        requires = {
    --            {
    --                'mfussenegger/nvim-dap',
    --            },
    --        },
    --    }
    --})




    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
