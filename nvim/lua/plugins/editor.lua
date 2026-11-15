-- Editing: syntax, autopairs, icons, indentation and completion.
return {
	-- Treesitter: highlighting and folds. A missing parser is installed the
	-- first time a file of that type is opened.
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local treesitter = require("nvim-treesitter")
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter-highlight", { clear = true }),
				callback = function(event)
					local lang = vim.treesitter.language.get_lang(event.match) or event.match
					if vim.treesitter.language.add(lang) then
						vim.treesitter.start(event.buf, lang)
					elseif vim.list_contains(treesitter.get_available(), lang) then
						local highlight = vim.schedule_wrap(function() pcall(vim.treesitter.start, event.buf, lang) end)
						treesitter.install(lang):await(highlight)
					end
				end,
			})
		end,
	},

	-- mini.nvim: autopairs and file icons
	{
		"nvim-mini/mini.nvim",
		lazy = false,
		config = function()
			require("mini.pairs").setup()
			require("mini.icons").setup()
		end,
	},

	-- Detect indentation from the file's contents
	{ "NMAC427/guess-indent.nvim", event = { "BufReadPost", "BufNewFile" }, opts = {} },

	-- Completion
	{
		"saghen/blink.cmp",
		version = "1.*",
		event = { "InsertEnter", "CmdlineEnter" },
		opts = {
			keymap = {
				["<CR>"] = { "accept", "fallback" },
				-- Snippet jump first, then Sidekick's next edit suggestion, then a literal <Tab>.
				["<Tab>"] = {
					"snippet_forward",
					function() return require("sidekick").nes_jump_or_apply() end,
					"fallback",
				},
			},
			completion = { documentation = { auto_show = true } },
			signature = { enabled = true },
		},
	},
}
