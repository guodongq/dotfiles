-- Test runner: run/debug individual tests or whole files without leaving nvim.
-- To add a language, install its neotest adapter and register it below.
-- `<leader>T*` uses a capital T to avoid clashing with `<leader>t` (Toggle).
local M = {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-treesitter/nvim-treesitter",
		"fredrikaverpil/neotest-golang",
		"nvim-neotest/neotest-python",
		"nvim-neotest/neotest-jest", -- swap for neotest-vitest/neotest-mocha if that's your JS runner
	},
	keys = {
		{ "<leader>Tt", function() require("neotest").run.run() end, desc = "[T]est Nearest" },
		{ "<leader>Tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "[T]est File" },
		{ "<leader>Td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "[T]est [D]ebug Nearest" },
		{ "<leader>Ts", function() require("neotest").summary.toggle() end, desc = "[T]est [S]ummary" },
		{ "<leader>To", function() require("neotest").output.open({ enter = true }) end, desc = "[T]est [O]utput" },
		{ "<leader>TO", function() require("neotest").output_panel.toggle() end, desc = "[T]est [O]utput Panel" },
		{ "<leader>TS", function() require("neotest").run.stop() end, desc = "[T]est [S]top" },
	},
}

M.config = function()
	require("neotest").setup({
		adapters = {
			require("neotest-golang")({}),
			require("neotest-python")({}),
			require("neotest-jest")({}),
		},
	})
end

return M
