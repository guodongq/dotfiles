local M = {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
        "theHamsta/nvim-dap-virtual-text",
        -- mason
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        -- dap-ui
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
    },
    keys = {
        {
            "<leader>dB",
            "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
            desc = "Breakpoint Condition",
            mode = "n",
        },
        { "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint", mode = "n" },
        { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue", mode = "n" },
        {
            "<leader>da",
            "<cmd>lua require'dap'.continue({ before = get_args })<cr>",
            desc = "Run With Args",
            mode = "n",
        },
        {
            "<leader>dC",
            "<cmd>lua require'dap'.run_to_cursor()<cr>",
            desc = "Run To Cursor",
            mode = "n",
        },
        { "<leader>dg", "<cmd>lua require'dap'.goto_()<cr>", desc = "Go To Line (No Execute)", mode = "n" },
        { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into", mode = "n" },
        { "<leader>dj", "<cmd>lua require'dap'.down()<cr>", desc = "Down", mode = "n" },
        { "<leader>dk", "<cmd>lua require'dap'.up()<cr>", desc = "Up", mode = "n" },
        { "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", desc = "Run Last", mode = "n" },
        { "<leader>do", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out", mode = "n" },
        { "<leader>dO", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over", mode = "n" },
        { "<leader>dp", "<cmd>lua require'dap'.pause()<cr>", desc = "Pause", mode = "n" },
        { "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Toggle REPL", mode = "n" },
        { "<leader>ds", "<cmd>lua require'dap'.session()<cr>", desc = "Session", mode = "n" },
        { "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", desc = "Terminate", mode = "n" },
        { "<leader>dw", "<cmd>lua require'dap.ui.widgets'.hover()<cr>", desc = "Widgets", mode = "n" },
        {
            "<leader>du",
            "<cmd>lua require'dapui'.toggle({})<cr>",
            desc = "Dap UI",
            mode = "n",
        },
        { "<leader>de", "<cmd>lua require'dapui'.eval()<cr>", desc = "Eval", mode = { "n", "v" } },
    },
}

function M.config()
    --------------------------
    -- Mason --
    --------------------------
    require("mason").setup()
    require("mason-nvim-dap").setup({
        ensure_installed = require("util.mason").dap,
        automatic_installation = true,
    })

    --------------------------
    -- Dap --
    --------------------------
    require("nvim-dap-virtual-text").setup()
    local dap = require("dap")
    -- C/C++ --
    -- dap.adapters.lldb = {
    --   type = "executable",
    --   command = "/opt/homebrew/opt/llvm/bin/lldb", -- adjust as needed, must be absolute path
    --   name = "lldb",
    -- }
    --
    -- dap.configurations.cpp = {
    --   {
    --     name = "Launch",
    --     type = "lldb",
    --     request = "launch",
    --     program = function()
    --       return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    --     end,
    --     cwd = "${workspaceFolder}",
    --     stopOnEntry = false,
    --     args = {},
    --     -- 💀
    --     -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --     --
    --     --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --     --
    --     -- Otherwise you might get the following error:
    --     --
    --     --    Error on launch: Failed to attach to the target process
    --     --
    --     -- But you should be aware of the implications:
    --     -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    --     -- runInTerminal = false,
    --   },
    -- }
    --
    -- dap.configurations.c = dap.configurations.cpp

    -- Go --
    dap.adapters.delve = {
        type = "server",
        port = "${port}",
        executable = {
            command = "dlv",
            args = { "dap", "-l", "127.0.0.1:${port}" },
        },
    }

    -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
    dap.configurations.go = {
        {
            type = "delve",
            name = "Debug",
            request = "launch",
            program = "${file}",
        },
        {
            type = "delve",
            name = "Debug test", -- configuration for debugging test files
            request = "launch",
            mode = "test",
            program = "${file}",
        },
        -- works with go.mod packages and sub packages
        {
            type = "delve",
            name = "Debug test (go.mod)",
            request = "launch",
            mode = "test",
            program = "./${relativeFileDirname}",
        },
    }

    -- Bash --
    -- dap.adapters.bashdb = {
    --   type = "executable",
    --   command = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
    --   name = "bashdb",
    -- }
    --
    -- dap.configurations.sh = {
    --   {
    --     type = "bashdb",
    --     request = "launch",
    --     name = "Launch file",
    --     showDebugOutput = true,
    --     pathBashdb = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
    --     pathBashdbLib = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
    --     trace = true,
    --     file = "${file}",
    --     program = "${file}",
    --     cwd = "${workspaceFolder}",
    --     pathCat = "cat",
    --     pathBash = "/bin/bash",
    --     pathMkfifo = "mkfifo",
    --     pathPkill = "pkill",
    --     args = {},
    --     env = {},
    --     terminalKind = "integrated",
    --   },
    -- }

    --------------------------
    -- Dap-UI --
    --------------------------
    require("dapui").setup({
        expand_lines = true,
        icons = { expanded = "", collapsed = "", circular = "" },
        mappings = {
            -- Use a table to apply multiple mappings
            expand = { "<CR>", "<2-LeftMouse>" },
            open = "o",
            remove = "d",
            edit = "e",
            repl = "r",
            toggle = "t",
        },
        layouts = {
            {
                elements = {
                    { id = "scopes", size = 0.33 },
                    { id = "breakpoints", size = 0.17 },
                    { id = "stacks", size = 0.25 },
                    { id = "watches", size = 0.25 },
                },
                size = 0.33,
                position = "right",
            },
            {
                elements = {
                    { id = "repl", size = 0.45 },
                    { id = "console", size = 0.55 },
                },
                size = 0.27,
                position = "bottom",
            },
        },
        floating = {
            max_height = 0.9,
            max_width = 0.5, -- Floats will be treated as percentage of your screen.
            border = vim.g.border_chars, -- Border style. Can be 'single', 'double' or 'rounded'
            mappings = {
                close = { "q", "<Esc>" },
            },
        },
    })

    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

    local dapui = require("dapui")
    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end
end

return M
