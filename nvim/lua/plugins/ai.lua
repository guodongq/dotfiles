local M = {
	"yetone/avante.nvim",
	-- 如果您想从源代码构建，请执行 `make BUILD_FROM_SOURCE=true`
	build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		or "make",
	event = "VeryLazy",
	enabled = false,
	version = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"echasnovski/mini.pick",
		"nvim-telescope/telescope.nvim",
		"hrsh7th/nvim-cmp",
		"ibhagwan/fzf-lua",
		"nvim-tree/nvim-web-devicons",
		"zbirenbaum/copilot.lua",
		{
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					use_absolute_path = true,
				},
			},
		},
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}

---@module 'avante'
---@type avante.Config
M.opts = {
	provider = "claude",
	providers = {
		claude = {
			endpoint = "https://api.anthropic.com",
			model = "claude-sonnet-4-20250514",
			timeout = 30000,
			extra_request_body = {
				temperature = 0.75,
				max_tokens = 20480,
			},
		},
		moonshot = {
			endpoint = "https://api.moonshot.ai/v1",
			model = "kimi-k2-0711-preview",
			timeout = 30000,
			extra_request_body = {
				temperature = 0.75,
				max_tokens = 32768,
			},
		},
	},
}

return M
