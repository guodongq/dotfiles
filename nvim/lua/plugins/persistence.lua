return {
	{ -- 持久化会话（恢复上次编辑状态）
		"folke/persistence.nvim",
		event = "BufReadPre", -- 读取文件前加载
		opts = {
			dir = vim.fn.stdpath("data") .. "/persistence/", -- 会话文件路径
			options = { "buffers", "curdir", "tabpages", "winsize" }, -- 保存的内容
		},
		keys = {
			{ "<leader>ps", "<cmd>lua require('persistence').save()<cr>", desc = "Quick [S]ave session" },
			{ "<leader>pr", "<cmd>lua require('persistence').load()<cr>", desc = "Quick [R]estore session" },
			{ "<leader>pd", "<cmd>lua require('persistence').stop()<cr>", desc = "Quick [D]elete session" },
		},
	},
}
