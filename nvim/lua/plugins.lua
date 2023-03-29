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

    ----------------------------------------
    -- Theme, Icons, Statusbar, Bufferbar --
    ----------------------------------------
    use({
        'kyazdani42/nvim-web-devicons',
        config = function()
            require('nvim-web-devicons').setup()
        end,
    })

    use({
        'numToStr/Sakura.nvim',
        config = function()
            require('plugins.sakura')
        end,
    })

    use({
        'nvim-lualine/lualine.nvim',
        after = 'Sakura.nvim',
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

    ---------------------------------
    -- Navigation and Fuzzy Search --
    ---------------------------------

    use({
        'nvim-tree/nvim-tree.lua',
        event = 'CursorHold',
        config = function()
            require('plugins.nvim-tree')
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
    })

    use({
        'numToStr/Navigator.nvim',
        event = 'CursorHold',
        config = function()
            require('plugins.navigator')
        end,
    })

    use({
        'phaazon/hop.nvim',
        event = 'BufRead',
        config = function()
            require('plugins.hop')
        end,
    })

    use({
        'karb94/neoscroll.nvim',
        event = 'WinScrolled',
        config = function()
            require('neoscroll').setup({ hide_cursor = false })
        end,
    })

    -------------------------
    -- Editing to the MOON --
    -------------------------

    use({
        'numToStr/Comment.nvim',
        event = 'BufRead',
        config = function()
            require('plugins.comment')
        end,
    })

    use({
        'numToStr/Buffers.nvim',
        event = 'BufRead',
        config = function()
            require('plugins.buffers')
        end,
    })

    --------------
    -- Terminal --
    --------------

    use({
        'numToStr/FTerm.nvim',
        event = 'CursorHold',
        config = function()
            require('plugins.fterm')
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
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            { 'williamboman/mason.nvim' }, -- Optional
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
            require('symbols-outline').setup()
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
        config = function()
            require('fidget').setup()
        end,
    })

    -----------------------------------
    -- Tools --
    -----------------------------------

    use({
        'folke/which-key.nvim',
        config = function()
            require('plugins.which-key')
        end,
    })

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
        'kowsmo7/window-picker.nvim',
        config = function()
            require('plugins.window-picker')
        end,
        event = 'VimEnter',
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


    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
