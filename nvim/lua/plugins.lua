local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	----------------------
	-- Required plugins --
	----------------------
	"nvim-lua/plenary.nvim",

	----------------------------------------
	-- Theme, Icons, Statusbar, Bufferbar --
	----------------------------------------
	{
		"kyazdani42/nvim-web-devicons",
		config = true,
	},

	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("tokyonight-night")
		end,
		enabled = true,
	},

	{
		"numToStr/Sakura.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("Sakura").load()
		end,
		enabled = false,
	},

	{
		"nvim-lualine/lualine.nvim",
		event = "BufEnter",
		config = function()
			require("plugins.lualine")
		end,
	},

	{
		"numToStr/Buffers.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>ba", "<cmd>lua require('Buffers').clear()<cr>", desc = "Close all buffers" },
			{ "<leader>bd", "<cmd>lua require('Buffers').delete()<cr>", desc = "Kill current buffer" },
			{ "<leader>bD", "<cmd>lua require('Buffers').only()<cr>", desc = "Kill other buffers" },
		},
	},

	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		opts = {
			options = {
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "center",
						separator = true,
					},
				},
			},
		},
		keys = {
			{ "<leader>bn", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
			{ "<leader>bp", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
			{ "<leader>bl", "<cmd>Telescope buffers path_display={'truncate'}<cr>", desc = "List buffers" },
		},
	},

	-----------------------------------
	-- Treesitter: Better Highlights --
	-----------------------------------
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "VeryLazy",
		dependencies = {
			"nvim-treesitter/playground", -- show treesitter nodes
			"nvim-treesitter/nvim-treesitter-textobjects", -- enable more advanced treesitter-aware text objects
			"JoosepAlviste/nvim-ts-context-commentstring",
			"nvim-treesitter/nvim-treesitter-refactor",
			"windwp/nvim-ts-autotag",
		},
		config = function()
			require("plugins.treesitter")
		end,
	},

	--------------------------
	-- Editor UI Niceties --
	--------------------------
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "VeryLazy",
		config = function()
			require("plugins.indentline")
		end,
	},

	{
		"norcalli/nvim-colorizer.lua",
		event = "VeryLazy",
		config = function()
			require("colorizer").setup()
		end,
	},

	---------------
	-- Git Stuff --
	---------------
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require("plugins.gitsigns")
		end,
	},

	{
		"rhysd/git-messenger.vim",
		event = "VeryLazy",
		config = function()
			vim.g.git_messenger_no_default_mappings = true
		end,
		keys = {
			{ "<leader>gm", "<CMD>GitMessenger<CR>", desc = "Reveal commit messages" },
		},
	},

	{
		"sindrets/diffview.nvim",
		event = "VeryLazy",
		config = function()
			require("diffview").setup({
				-- See ':h diffview-config-enhanced_diff_hl'
				enhanced_diff_hl = true,
				view = {
					merge_tool = {
						layout = "diff3_mixed",
					},
				},
			})
		end,
		keys = {
			{ "<leader>gd", "<CMD>DiffviewOpen<CR>", desc = "Git diffview open" },
			{ "<leader>gD", "<CMD>DiffviewClose<CR>", desc = "Git diffview close" },
		},
	},

	---------------------------------
	-- Navigation and Fuzzy Search --
	---------------------------------
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		event = "VeryLazy",
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<leader>ft", "<cmd>NvimTreeToggle<cr>", desc = "File tree" },
			{ "<leader>fT", "<cmd>NvimTreeFindFile<cr>", desc = "Focus current file in file tree" },
		},
		config = function()
			require("plugins.nvim-tree")
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			"nvim-telescope/telescope-symbols.nvim",
			{
				"ahmedkhalf/project.nvim",
				config = function()
					require("project_nvim").setup()
				end,
			},
		},
		config = function()
			require("plugins.telescope")
		end,
		keys = {
			{ "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in current buffer" },
			{ "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Search files(root dir)" },
			{ "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Search grep" },
			{
				"<leader>sp",
				"<cmd>lua require('telescope').extensions.projects.projects{}<cr>",
				desc = "Search project",
			},
			{ "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Search recent" },
			{ "<leader>st", "<cmd>Telescope<cr>", desc = "Search(Telescope)" },
		},
	},

	{
		"numToStr/Navigator.nvim",
		event = "VeryLazy",
		config = function()
			require("plugins.navigator")
		end,
	},

	{
		"smoka7/hop.nvim",
		version = "*",
		event = "VeryLazy",
		opts = {},
		keys = {
			{ "<leader>j1", "<cmd>HopChar1<cr>", desc = "jump-or-select-to-a-character" },
			{ "<leader>j2", "<cmd>HopChar2<cr>", desc = "jump-to-suite-of-two-characters" },
			{ "<leader>jl", "<cmd>HopLine<cr>", desc = "jump-or-select-to-a-line" },
			{ "<leader>jp", "<cmd>HopPattern<cr>", desc = "jump-or-select-to-a-pattern" },
			{ "<leader>jw", "<cmd>HopWord<cr>", desc = "jump-to-a-word" },
		},
	},

	{
		"karb94/neoscroll.nvim",
		event = "VeryLazy",
		config = function()
			require("neoscroll").setup({ hide_cursor = false })
		end,
	},

	-------------------------
	-- Editing to the MOON --
	-------------------------
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		config = true,
		keys = {
			{
				"<leader>cb",
				"<cmd>lua require('Comment.api').toggle.blockwise.current()<cr>",
				desc = "comment-or-uncomment-blocks",
			},
			{
				"<leader>co",
				"<cmd>lua require('Comment.api').insert.linewise.below()<cr>",
				desc = "comment-line-below",
			},
			{
				"<leader>c0",
				"<cmd>lua require('Comment.api').insert.linewise.above()<cr>",
				desc = "comment-line-above",
			},
			{
				"<leader>c/",
				"<cmd>lua require('Comment.api').toggle.linewise.current()<cr>",
				desc = "comment-line-above",
			},
			{ "<leader>c$", "<cmd>lua require('Comment.api').insert.linewise.eol()<cr>", desc = "comment-end-of-line" },
			-- visual
			{
				"<leader>cb",
				"<esc><cmd>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<cr>",
				desc = "comment-or-uncomment-blocks",
				mode = "v",
			},
			{
				"<leader>c/",
				"<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
				desc = "comment-or-uncomment-lines",
				mode = "v",
			},
		},
	},

	-- todo: vim-surround

	--------------
	-- Terminal --
	--------------
	{
		"akinsho/toggleterm.nvim",
		event = "VeryLazy",
		version = "*",
		config = function()
			require("plugins.toggleterm")
		end,
	},

	-----------------------------------
	-- LSP, Completions and Snippets --
	-----------------------------------
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		dependencies = {
			-- WARN: Unfortunately we don't be able to lazy load this
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			require("plugins.lsp.servers")
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		event = "VeryLazy",
		config = function()
			require("plugins.lsp.nvim-cmp")
		end,
		dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
			{
				"L3MON4D3/LuaSnip",
				event = "VeryLazy",
				config = function()
					require("plugins.lsp.luasnip")
				end,
				dependencies = {
					"rafamadriz/friendly-snippets",
					event = "VeryLazy",
				},
			},
		},
	},


	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		event = "VeryLazy",
		keys = {
			{ "<leader>lm", "<cmd>Mason<cr>", desc = "Mason" },
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				automatic_installation = true,
				ensure_installed = {
					"asm_lsp",
					"bashls",
					"clangd",
					"cmake",
					"gopls",
					"jsonls",
					"marksman",
					"lua_ls",
					"pyright",
					"taplo",
					"terraformls",
					"yamlls",
				},
			})
		end,
	},


	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "VeryLazy",
		config = function()
			require("plugins.lsp.null-ls")
		end,
	},

	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-null-ls").setup({
				automatic_installation = true,
				ensure_installed = {
					"clang-format",
					"cmakelang",
					"gitlint",
					"goimports",
					"golangci-lint",
					"jsonlint",
					"markdownlint",
					"protolint",
					"pylint",
					"yamllint",
				},
			})
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = "VeryLazy",
		dependencies = "hrsh7th/nvim-cmp",
		config = function()
			require("nvim-autopairs").setup()

			-- Integration w/ nvim-cmp
			require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
		end,
	},

	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		event = "VeryLazy",
		opts = {},
	},

	{
		"simrat39/symbols-outline.nvim",
		config = function()
			require("plugins.lsp.outline")
		end,
		event = "VeryLazy",
		keys = {
			{ "<leader>lo", "<cmd>SymbolsOutline<cr>", desc = "Outline" },
		},
	},

	{
		"nvim-pack/nvim-spectre",
		event = "VeryLazy",
		config = true,
		keys = {
			{ "<leader>lr", "<cmd>lua require('spectre').open()<cr>", desc = "Replace in files(Spectre)" },
		},
	},

	-----------------------------------
	-- Windows --
	-----------------------------------
	{
		"0x00-ketsu/maximizer.nvim",
		config = true,
		keys = {
			{ "<leader>wm", "<cmd>lua require('maximizer').toggle()<cr>", desc = "Maximize current window" },
		},
	},

	{
		"yorickpeterse/nvim-window",
		config = true,
		keys = {
			{ "<leader>wc", "<cmd>lua require('nvim-window').pick()<cr>", desc = "Choose a window" },
		},
	},

	-----------------------------------
	-- Tools --
	-----------------------------------
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		config = function()
			local configs = require("alpha.themes.startify").config
			--local configs = require("alpha.themes.dashboard").config
			require("alpha").setup(configs)
		end,
	},

	{
		"folke/which-key.nvim",
		event = "VimEnter",
		opts = {
			plugins = { spelling = true },
			defaults = {
				mode = { "n", "v" },
				["<leader>b"] = { name = "+buffer" },
				["<leader>c"] = { name = "+comment" },
				["<leader>f"] = { name = "+file" },
				["<leader>g"] = { name = "+git" },
				["<leader>h"] = { name = "+help" },
				["<leader>j"] = { name = "+jump" },
				["<leader>l"] = { name = "+lsp" },
				["<leader>q"] = { name = "+quit" },
				["<leader>s"] = { name = "+search" },
				["<leader>w"] = { name = "+window" },
			},
		},
		config = function(_, opts)
			vim.o.timeout = true
			vim.o.timeoutlen = 300

			local wk = require("which-key")
			wk.setup(opts)
			wk.register(opts.defaults)
		end,
	},
})
