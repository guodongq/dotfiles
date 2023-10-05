return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"zbirenbaum/copilot-cmp",
			"onsails/lspkind-nvim",
			{ "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
		},
		config = function()
			local lspkind = require("lspkind")
			local cmp = require("cmp")
			local tailwind_formatter = require("tailwindcss-colorizer-cmp").formatter

			vim.o.completeopt = "menu,menuone,noselect"

			cmp.setup({
				ghost_text = { enabled = true },
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				mapping = {
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				},
				sources = cmp.config.sources({
					{ name = "copilot" },
					{ name = "vsnip" },
					{ name = "nvim_lua" },
					{ name = "nvim_lsp" },
					{ name = "buffer", keyword_length = 5, max_item_count = 5 },
					{ name = "path" },
				}),
				formatting = {
					fields = { cmp.ItemField.Menu, cmp.ItemField.Abbr, cmp.ItemField.Kind },
					format = lspkind.cmp_format({
						with_text = true,
						menu = {
							nvim_lsp = "ﲳ",
							nvim_lua = "",
							path = "ﱮ",
							buffer = "﬘",
							vsnip = "",
							-- treesitter = "",
							-- zsh = "",
							-- spell = "暈"
						},
						before = tailwind_formatter,
					}),
				},
				experimental = { native_menu = false, ghost_text = { enabled = true } },
			})

			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},
}
