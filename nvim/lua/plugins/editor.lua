-- Editing: syntax, text objects, motions, search and replace, sessions.
return {
	-- Treesitter: highlighting and folds. A missing parser is installed the
	-- first time a file of that type is opened.
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter-highlight", { clear = true }),
				callback = function(event)
					local lang = vim.treesitter.language.get_lang(event.match) or event.match
					if vim.treesitter.language.add(lang) then
						vim.treesitter.start(event.buf, lang)
					elseif vim.list_contains(require("nvim-treesitter").get_available(), lang) then
						require("nvim-treesitter").install(lang):await(function()
							vim.schedule(function() pcall(vim.treesitter.start, event.buf, lang) end)
						end)
					end
				end,
			})
		end,
	},

	-- mini.nvim: text objects (ai), surround, autopairs and icons
	{
		"nvim-mini/mini.nvim",
		lazy = false,
		init = function()
			-- Serve plugins that ask for nvim-web-devicons from mini.icons.
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
		config = function()
			require("mini.ai").setup({ n_lines = 500 })
			require("mini.surround").setup()
			require("mini.pairs").setup()
			require("mini.icons").setup()
		end,
	},

	-- Jump anywhere with labels. Under <leader>j because mini.surround owns `s`.
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			-- Keep f/F/t/T on the current line, without dimming the buffer.
			modes = { char = { multi_line = false, highlight = { backdrop = false } } },
		},
		keys = {
			{
				"<leader>jw",
				function() require("flash").jump() end,
				mode = { "n", "x", "o" },
				desc = "[J]ump To [W]ord",
			},
			{
				"<leader>jt",
				function() require("flash").treesitter() end,
				mode = { "n", "x", "o" },
				desc = "[J]ump [T]reesitter Node",
			},
		},
	},

	-- Detect indentation from the file's contents
	{ "NMAC427/guess-indent.nvim", event = { "BufReadPost", "BufNewFile" }, opts = {} },

	-- Search and replace across the project
	{
		"nvim-pack/nvim-spectre",
		build = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = "Spectre",
		opts = { open_cmd = "noswapfile vnew" },
		keys = {
			{ "<leader>R", function() require("spectre").open() end, desc = "Spectre: [R]eplace in Files" },
		},
	},

	-- Sessions: reopen the files and layout of a project directory
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {},
		keys = {
			{ "<leader>ps", function() require("persistence").load() end, desc = "Session: Restore" },
			{
				"<leader>pl",
				function() require("persistence").load({ last = true }) end,
				desc = "Session: Restore Last",
			},
			{ "<leader>pd", function() require("persistence").stop() end, desc = "Session: Don't Save" },
		},
	},

	-- Markdown preview in the browser: :LivePreview start / close
	{
		"brianhuster/live-preview.nvim",
		cmd = "LivePreview",
		keys = {
			{ "<leader>cp", "<cmd>LivePreview start<cr>", ft = "markdown", desc = "Markdown [P]review" },
		},
		-- `:LivePreview pick` would otherwise pick mini.pick, which isn't set up.
		config = function() require("livepreview.config").set({ picker = "vim.ui.select" }) end,
	},
}
