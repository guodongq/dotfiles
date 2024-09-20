local M = {
	"akinsho/toggleterm.nvim",
	version = "*",
	event = "VeryLazy",
	opts = {
		size = 20,
		open_mapping = [[<c-\>]],
		hide_numbers = true,
		shade_terminals = true,
		shading_factor = 2,
		start_in_insert = true,
		insert_mappings = true,
		persist_size = true,
		direction = "horizontal", -- float, horizontal
		close_on_exit = true,
		shell = vim.o.shell,
		float_opts = {
			border = "curved",
		},
	},
}

function M.config(_, opts)
	require("toggleterm").setup(opts)

	function _G.set_terminal_keymaps()
		local opts = { noremap = true }
		vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<cmd>wincmd h<cr>]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<cmd>wincmd j<cr>]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<cmd>wincmd k<cr>]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<cmd>wincmd l<cr>]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-w>", [[<C-\><C-n><C-W>]], opts)
	end

	vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

	local Terminal = require("toggleterm.terminal").Terminal
	local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

	function _LAZYGIT_TOGGLE()
		lazygit:toggle()
	end
end

return M
