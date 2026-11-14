-- Syntax, autopairs, icons and indentation.
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
}
