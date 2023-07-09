-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand:
vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("PACKER", { clear = true }),
	pattern = "plugins.lua",
	command = "source <afile> | PackerCompile",
})

local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup({
	function(use)
		---------------------
		-- Package Manager --
		---------------------

		use("wbthomason/packer.nvim")

		----------------------
		-- Required plugins --
		----------------------

		use("nvim-lua/plenary.nvim")

		-----------------------------------
		-- Startup plugins --
		-----------------------------------

		use({
			"folke/noice.nvim",
			requires = {
				"MunifTanjim/nui.nvim",
				"rcarriga/nvim-notify",
			},
			config = function()
				require("plugins.noice")
			end,
		})

		use({
			"folke/which-key.nvim",
			config = function()
				vim.o.timeout = true
				vim.o.timeoutlen = 300
				require("plugins.which-key")
			end,
		})

		use({
			"goolord/alpha-nvim",
			event = "VimEnter",
			requires = { "nvim-tree/nvim-web-devicons" },
			config = function()
				require("alpha").setup(require("alpha.themes.startify").config)
				--require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
			end,
		})

		----------------------------------------
		-- Theme, Icons, Statusbar, Bufferbar --
		----------------------------------------

		use({
			"kyazdani42/nvim-web-devicons",
			config = function()
				require("nvim-web-devicons").setup()
			end,
		})

		use({
			"folke/tokyonight.nvim",
			config = function()
				require("plugins.colorscheme")
			end,
		})

		use({
			"nvim-lualine/lualine.nvim",
			after = "tokyonight.nvim",
			event = "BufEnter",
			config = function()
				require("plugins.lualine")
			end,
		})

		use("numToStr/Buffers.nvim")

		---------------------------------
		-- Navigation and Fuzzy Search --
		---------------------------------

		use({
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v2.x",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
				"MunifTanjim/nui.nvim",
			},
			config = function()
				require("plugins.neo-tree")
			end,
		})

		use({
			{
				"nvim-telescope/telescope.nvim",
				event = "VimEnter",
				config = function()
					require("plugins.telescope")
				end,
			},
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				after = "telescope.nvim",
				run = "make",
				config = function()
					require("telescope").load_extension("fzf")
				end,
			},
			{
				"nvim-telescope/telescope-symbols.nvim",
				after = "telescope.nvim",
			},
			{
				"ahmedkhalf/project.nvim",
				after = "telescope.nvim",
				config = function()
					require("telescope").load_extension("projects")
					require("project_nvim").setup()
				end,
			},
			{
				"nvim-telescope/telescope-dap.nvim",
				after = { "telescope.nvim", "nvim-dap" },
				config = function()
					require("telescope").load_extension("dap")
				end,
			},
		})

		-----------------------------------
		-- Treesitter: Better Highlights --
		-----------------------------------

		use({
			{
				"nvim-treesitter/nvim-treesitter",
				event = "CursorHold",
				run = ":TSUpdate",
				config = function()
					require("plugins.treesitter")
				end,
			},
			{ "nvim-treesitter/playground", after = "nvim-treesitter" },
			{ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },
			{ "nvim-treesitter/nvim-treesitter-refactor", after = "nvim-treesitter" },
			{ "windwp/nvim-ts-autotag", after = "nvim-treesitter" },
			{ "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" },
		})

		--------------
		-- Terminal --
		--------------

		use({
			"akinsho/toggleterm.nvim",
			tag = "*",
			event = "CursorHold",
			config = function()
				require("plugins.toggleterm")
			end,
		})

		-----------------------------------
		-- LSP, Completions, Formatting and Snippets --
		-----------------------------------

		use({
			"VonHeikemen/lsp-zero.nvim",
			config = function()
				require("plugins.lsp")
			end,
			branch = "v2.x",
			requires = {
				-- LSP Support
				{ "neovim/nvim-lspconfig" }, -- Required
				{
					"williamboman/mason.nvim",
					run = function()
						pcall(vim.cmd, "MasonUpdate")
					end,
				}, -- Optional
				{ "williamboman/mason-lspconfig.nvim" }, -- Optional

				-- Autocompletion
				{ "hrsh7th/nvim-cmp" }, -- Required
				{ "hrsh7th/cmp-nvim-lsp" }, -- Required
				{ "hrsh7th/cmp-buffer" }, -- Optional
				{ "hrsh7th/cmp-path" }, -- Optional
				{ "saadparwaiz1/cmp_luasnip" }, -- Optional
				{ "hrsh7th/cmp-nvim-lua" }, -- Optional

				-- Snippets
				{ "L3MON4D3/LuaSnip" }, -- Required
				{ "rafamadriz/friendly-snippets" }, -- Optional
			},
		})

		-- NOTE: nvim-autopairs needs to be loaded after nvim-cmp, so that <CR> would work properly
		use({
			"windwp/nvim-autopairs",
			after = "nvim-cmp",
			config = function()
				require("plugins.autopairs")
			end,
		})

		use({
			"j-hui/fidget.nvim",
			tag = "legacy",
			config = function()
				require("fidget").setup()
			end,
		})

		use({
			"simrat39/symbols-outline.nvim",
			config = function()
				require("symbols-outline").setup({
					show_numbers = true,
				})
			end,
		})

		use({
			{
				"jose-elias-alvarez/null-ls.nvim",
				event = "BufRead",
				config = function()
					require("plugins.null-ls")
				end,
			},
			{
				"jay-babu/mason-null-ls.nvim",
				after = { "mason.nvim", "null-ls.nvim" },
				config = function()
					require("mason-null-ls").setup({
						automatic_setup = true,
						ensure_installed = { "stylua", "prettier", "buf" },
						automatic_installation = true,
					})
				end,
			},
		})

		--------------
		-- Coding --
		--------------

		use({
			"nvim-pack/nvim-spectre",
			event = "BufReadPost",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("spectre").setup()
			end,
		})

		--------------------------
		-- Editor UI Niceties --
		--------------------------

		use({
			"lukas-reineke/indent-blankline.nvim",
			event = "BufRead",
			config = function()
				require("indent_blankline").setup({
					show_first_indent_level = false,
					filetype_exclude = { "help", "packer", "toggleterm" },
					buftype_exclude = { "terminal", "nofile" },
				})
			end,
		})

		use({
			"karb94/neoscroll.nvim",
			event = "WinScrolled",
			config = function()
				require("neoscroll").setup({ hide_cursor = false })
			end,
		})

		-------------------------
		-- Editing to the MOON --
		-------------------------

		use({
			"numToStr/Comment.nvim",
			event = "BufRead",
			config = function()
				require("Comment").setup()
			end,
		})

		use({
			"phaazon/hop.nvim",
			event = "BufRead",
			config = function()
				-- you can configure Hop the way you like here; see :h hop-config
				require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
			end,
		})

		use({
			"iamcco/markdown-preview.nvim",
			run = function()
				vim.fn["mkdp#util#install"]()
			end,
		})

		---------------
		-- Git Stuff --
		---------------

		use({
			"lewis6991/gitsigns.nvim",
			event = "BufRead",
			config = function()
				require("gitsigns").setup({})
			end,
		})

		use({
			"rhysd/git-messenger.vim",
			event = "BufRead",
			config = function()
				vim.g.git_messenger_no_default_mappings = true
			end,
		})

		use({
			"sindrets/diffview.nvim",
			event = "BufRead",
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
		})

		---------------
		-- Windows --
		---------------

		use({
			"eduardomillans/maximizer.nvim",
			config = function()
				require("plugins.maximizer")
			end,
			event = "VimEnter",
		})

		use({
			"yorickpeterse/nvim-window",
			config = function()
				require("plugins.window")
			end,
			event = "VimEnter",
		})

		-----------------------------------
		-- Debugger --
		-----------------------------------

		use({
			{
				"mfussenegger/nvim-dap",
				--event = "CursorHold",
				config = function()
					require("plugins.dap")
				end,
			},
			{
				"jay-babu/mason-nvim-dap.nvim",
				after = { "nvim-dap", "mason.nvim" },
				config = function()
					require("mason-nvim-dap").setup({
						automatic_setup = true,
						ensure_installed = { "delve", "cpptools" },
						automatic_installation = true,
					})
				end,
			},
			{
				"theHamsta/nvim-dap-virtual-text",
				after = { "nvim-dap", "nvim-treesitter" },
				config = function()
					require("nvim-dap-virtual-text").setup()
				end,
			},
			{
				"rcarriga/nvim-dap-ui",
				after = { "nvim-dap" },
				config = function()
					local dap = require("dap")
					local dapui = require("dapui")
					dapui.setup({})
					dap.listeners.after.event_initialized["dapui_config"] = function()
						dapui.open({})
					end
					dap.listeners.before.event_terminated["dapui_config"] = function()
						dapui.close({})
					end
					dap.listeners.before.event_exited["dapui_config"] = function()
						dapui.close({})
					end
				end,
			},
		})

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
	},
})
