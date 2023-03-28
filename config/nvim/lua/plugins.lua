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

return require('packer').startup({
    function(use)
        ---------------------
        -- Package Manager --
        ---------------------
        use('wbthomason/packer.nvim')

        ----------------------
        -- Required plugins --
        ----------------------
        use('nvim-lua/plenary.nvim')
        use('lewis6991/impatient.nvim')

        ----------------------------------------
        -- Theme, Icons, Statusbar, Bufferbar --
        ----------------------------------------
        use({
            'nvim-tree/nvim-web-devicons',
            config = function()
                require('nvim-web-devicons').setup()
            end,
        })

        use({
            'folke/tokyonight.nvim',
            config = function()
                require('plugins.colors')
            end,
        })

        use({
            'nvim-lualine/lualine.nvim',
            event = 'VimEnter',
            config = function()
                require('plugins.lualine')
            end,
            requires = {
                { 'nvim-tree/nvim-web-devicons' }
            }
        })

        use({
            'akinsho/bufferline.nvim',
            tag = 'v3.*',
            event = 'VimEnter',
            after = { 'tokyonight.nvim' },
            config = function()
                require('plugins.bufferline')
            end,
            requires = {
                { 'moll/vim-bbye' },
                { 'nvim-tree/nvim-web-devicons' },
                { 'famiu/bufdelete.nvim' },
            }
        })

        use({
            'goolord/alpha-nvim',
            event = 'VimEnter',
            config = function()
                require("plugins.dashboard")
            end,
        })

        ---------------------------------
        -- Navigation and Fuzzy Search --
        ---------------------------------
        use({
            'nvim-tree/nvim-tree.lua',
            config = function()
                require('plugins.nvim-tree')
            end,
            after = { 'tokyonight.nvim' },
            requires = {
                { 'nvim-tree/nvim-web-devicons' },
            }
        })

        use({
            {
                'nvim-telescope/telescope.nvim',
                event = 'CursorHold',
                config = function()
                    require('plugins.telescope')
                end,
                requires = {
                    { 'nvim-lua/plenary.nvim' },
                },
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
                'nvim-telescope/telescope-project.nvim',
                after = 'telescope.nvim',
                config = function()
                    require('telescope').load_extension('project')
                end,
            },
        })

        use({
            'phaazon/hop.nvim',
            branch = 'v2',
            event = 'BufReadPost',
            config = function()
                require('plugins.hop')
            end,
        })

        use({
            'numToStr/Navigator.nvim',
            event = 'CursorHold',
            config = function()
                require('plugins.navigator')
            end,
        })

        use({
            'karb94/neoscroll.nvim',
            event = 'WinScrolled',
            config = function()
                require('neoscroll').setup({ hide_cursor = false })
            end,
        })

        -----------------------------------
        -- Treesitter: Better Highlights --
        -----------------------------------
        use({
            {
                'nvim-treesitter/nvim-treesitter',
                run = ':TSUpdate',
                config = function()
                    require('plugins.treesitter')
                end,
            },
            { 'nvim-treesitter/playground', requires = { 'nvim-treesitter/nvim-treesitter' } },
            { 'nvim-treesitter/nvim-treesitter-refactor', requires = { 'nvim-treesitter/nvim-treesitter' } },
            { 'nvim-treesitter/nvim-treesitter-textobjects', requires = { 'nvim-treesitter/nvim-treesitter' } },
            { 'p00f/nvim-ts-rainbow', requires = { 'nvim-treesitter/nvim-treesitter' } },
            { 'JoosepAlviste/nvim-ts-context-commentstring', requires = { 'nvim-treesitter/nvim-treesitter' } },
            { 'nvim-treesitter/nvim-treesitter-context', requires = { 'nvim-treesitter/nvim-treesitter' } },
            { 'windwp/nvim-ts-autotag', requires = { 'nvim-treesitter/nvim-treesitter' } },
        })

        ----------------------------
        ---- Editor UI Niceties --
        ----------------------------
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
        --
        -----------------
        ---- Git Stuff --
        -----------------
        use({
            'lewis6991/gitsigns.nvim',
            event = { 'BufReadPost', 'BufNewFile' },
            config = function()
                require('gitsigns').setup()
            end,
        })

        use({
            'rhysd/git-messenger.vim',
            event = 'BufRead',
            config = function()
                require('plugins.git-messenger')
            end,
        })

        use({
            'sindrets/diffview.nvim',
            event = 'BufRead',
            config = function()
                require('plugins.diffview')
            end,
        })

        ---------------------------
        ---- Editing to the MOON --
        ---------------------------
        use({
            'numToStr/Comment.nvim',
            event = 'BufRead',
            config = function()
                require('plugins.comment')
            end,
            after = 'nvim-ts-context-commentstring',
        })

        -- use('numToStr/prettierrc.nvim')

        use({
            'tpope/vim-surround',
            event = 'BufRead',
            requires = {
                {
                    'tpope/vim-repeat',
                    event = 'BufRead',
                },
            },
        })

        use({
            'wellle/targets.vim',
            event = 'BufRead',
        })

        use({
            'AndrewRadev/splitjoin.vim',
            -- NOTE: splitjoin won't work with `BufRead` event
            event = 'CursorHold',
        })

        ----------------
        ---- Terminal --
        ----------------
        use({
            'akinsho/toggleterm.nvim',
            tag = '*',
            event = 'UIEnter',
            config = function()
                require('plugins.toggleterm')
            end,
        })

        -------------------------------------
        ---- LSP, Completions and Snippets --
        -------------------------------------
        use({
            'williamboman/mason-lspconfig.nvim',
            event = 'VimEnter',
            after = { 'mason.nvim', 'nvim-lspconfig' },
            config = function()
                require('plugins.lsp.mason')
            end,
            requires = {
                { 'williamboman/mason.nvim' },
            },
        })

        use({
            {
                'neovim/nvim-lspconfig',
                config = function()
                    require('plugins.lsp.servers')
                end,
                after = 'cmp-nvim-lsp',
                requires = {
                    {
                        -- WARN: Unfortunately we won't be able to lazy load this
                        'hrsh7th/cmp-nvim-lsp',
                    },
                },
            },
            {
                'jose-elias-alvarez/null-ls.nvim',
                event = 'BufRead',
                config = function()
                    require('plugins.lsp.null-ls')
                end,
            },
            {
                'simrat39/symbols-outline.nvim',
                config = function()
                    require('symbols-outline').setup()
                end,
                requires = {
                    { 'neovim/nvim-lspconfig' },
                }
            }
        })

        use({
            {
                'hrsh7th/nvim-cmp',
                event = { 'InsertEnter', 'CmdlineEnter' },
                config = function()
                    require('plugins.lsp.nvim-cmp')
                end,
                requires = {
                    {
                        'L3MON4D3/LuaSnip',
                        event = { 'InsertEnter', 'CmdlineEnter' },
                        config = function()
                            require('plugins.lsp.luasnip')
                        end,
                        requires = {
                            { 'rafamadriz/friendly-snippets' },
                        },
                    },
                },
            },
            { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
            { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' },
        })

        ---- NOTE: nvim-autopairs needs to be loaded after nvim-cmp, so that <CR> would work properly
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
            config = function()
                require('fidget').setup({
                    sources = { ['null-ls'] = { ignore = true } },
                })
            end,
        })

        ------------------------------------------
        ---- Tools, Helper --
        ------------------------------------------
        use {
            'folke/which-key.nvim',
            config = function()
                require('plugins.which-key')
            end,
        }

        use {
            'eduardomillans/maximizer.nvim',
            config = function()
                require('plugins.maximizer')
            end,
            event = 'VimEnter',
        }

        use {
            'kowsmo7/window-picker.nvim',
            config = function()
                require('plugins.window-picker')
            end,
            event = 'VimEnter',
        }

        use({
            'folke/todo-comments.nvim',
            after = 'nvim-treesitter',
            event = 'BufReadPost',
            requires = 'nvim-lua/plenary.nvim',
            config = function()
                require('todo-comments').setup()
            end,
        })

        use({
            'nvim-neotest/neotest',
            after = 'nvim-treesitter',
            requires = {
                'nvim-lua/plenary.nvim',
                'nvim-treesitter/nvim-treesitter',
                'antoinemadec/FixCursorHold.nvim',
                'haydenmeade/neotest-jest',
            },
            config = function()
                require('plugins.neotest')
            end,
        })

        use({
            'kevinhwang91/nvim-bqf',
            ft = 'qf',
            config = function()
                require('bqf').setup({
                    preview = {
                        border_chars = {
                            '│',
                            '│',
                            '─',
                            '─',
                            '┌',
                            '┐',
                            '└',
                            '┘',
                            '█',
                        },
                    },
                })
            end,
        })

        use({
            'sbdchd/neoformat',
            cmd = 'Neoformat'
        })

        use({
            'kevinhwang91/nvim-ufo',
            requires = {
                { 'kevinhwang91/promise-async' },
            },
            config = function()
                require('plugins.ufo')
            end,
        })

        use({
            'danymat/neogen',
            requires = {
                { 'nvim-treesitter/nvim-treesitter' },
            },
            config = function()
                require('neogen').setup({
                    snippet_engine = 'luasnip',
                })
            end,
        })

        use({
            'nvim-zh/colorful-winsep.nvim',
            config = function()
                require('colorful-winsep').setup()
            end,
        })

        -----------------------------------
        -- DAP --
        -----------------------------------
        use({
            'rcarriga/nvim-dap-ui',
            config = function()
                require('plugins.dap')
            end,
            event = 'CursorHold',
            requires = {
                { 'mfussenegger/nvim-dap' },
                { 'theHamsta/nvim-dap-virtual-text' },
            }
        })

        -- Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all plugins
        if packer_bootstrap then
            require('packer').sync()
        end
    end,
    config = {
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'single' })
            end,
        },
    },
})
