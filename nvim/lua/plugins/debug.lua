local M = {
	"mfussenegger/nvim-dap",
	enabled = false,
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"mason-org/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		"leoluz/nvim-dap-go",
	},
	keys = {
		{ "<F7>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
		{ "<F8>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
		{ "<S-F8>", function() require("dap").step_out() end, desc = "Debug: Step Out" },
		{ "<F9>", function() require("dap").continue() end, desc = "Debug: Start/Continue" },
		{ "<leader>tb", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
		{ "<leader>B", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Debug: Set Breakpoint" },
		{ "<F5>", function() require("dapui").toggle() end, desc = "Debug: See last session result." },
	},
}

M.config = function()
	local dap = require("dap")
	local dapui = require("dapui")

	require("mason-nvim-dap").setup({
		automatic_installation = true,
		handlers = {},
		ensure_installed = {
			"delve",
		},
	})

	dapui.setup({
		icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
		controls = {
			icons = {
				pause = "⏸",
				play = "▶",
				step_into = "⏎",
				step_over = "⏭",
				step_out = "⏮",
				step_back = "b",
				run_last = "▶▶",
				terminate = "⏹",
				disconnect = "⏏",
			},
		},
	})

	vim.api.nvim_set_hl(0, "DapBreak", { fg = "#e51400" })
	vim.api.nvim_set_hl(0, "DapStop", { fg = "#ffcc00" })
	local breakpoint_icons = vim.g.have_nerd_font
			and {
				Breakpoint = "",
				BreakpointCondition = "",
				BreakpointRejected = "",
				LogPoint = "",
				Stopped = "",
			}
		or {
			Breakpoint = "●",
			BreakpointCondition = "⊜",
			BreakpointRejected = "⊘",
			LogPoint = "◆",
			Stopped = "⭔",
		}
	for type, icon in pairs(breakpoint_icons) do
		local tp = "Dap" .. type
		local hl = (type == "Stopped") and "DapStop" or "DapBreak"
		vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
	end

	dap.listeners.after.event_initialized["dapui_config"] = dapui.open
	dap.listeners.before.event_terminated["dapui_config"] = dapui.close
	dap.listeners.before.event_exited["dapui_config"] = dapui.close

	require("dap-go").setup({
		delve = {
			detached = vim.fn.has("win32") == 0,
		},
	})
end

return M
