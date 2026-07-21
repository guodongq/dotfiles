local M = {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"mason-org/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		"leoluz/nvim-dap-go",
		"mfussenegger/nvim-dap-python",
	},
	keys = {
		{ "<F7>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
		{ "<F8>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
		{ "<S-F8>", function() require("dap").step_out() end, desc = "Debug: Step Out" },
		{ "<F9>", function() require("dap").continue() end, desc = "Debug: Start/Continue" },
		{ "<leader>tb", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
		{ "<leader>B", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Debug: Set [B]reakpoint" },
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
			"debugpy",
			"js-debug-adapter",
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

	-- Python: swap "python3" for "uv" below if you manage envs with uv.
	require("dap-python").setup("python3")

	-- JS/TS: mason installs js-debug-adapter, but unlike Go/Python there's no
	-- small companion plugin, so it's wired up by hand.
	local js_debug_ok, js_debug_path = pcall(function()
		return require("mason-registry").get_package("js-debug-adapter"):get_install_path()
	end)
	if js_debug_ok then
		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				args = { js_debug_path .. "/js-debug/src/dapDebugServer.js", "${port}" },
			},
		}
		for _, language in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
			dap.configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach to process",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
			}
		end
	end
end

return M
