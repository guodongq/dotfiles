local M = {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPost", "BufNewFile" },
}

M.opts = {
	signs = {
		add          = { text = "+" },
		change       = { text = "~" },
		delete       = { text = "_" },
		topdelete    = { text = "‾" },
		changedelete = { text = "~" },
	},
	on_attach = function(bufnr)
		local gs = require("gitsigns")
		local function map(mode, keys, func, desc)
			vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "Git: " .. desc })
		end
		-- Hunk navigation
		map("n", "]h", gs.next_hunk, "Next [H]unk")
		map("n", "[h", gs.prev_hunk, "Prev [H]unk")
		-- Hunk actions
		map("n", "<leader>hs", gs.stage_hunk,   "[H]unk [S]tage")
		map("n", "<leader>hr", gs.reset_hunk,   "[H]unk [R]eset")
		map("n", "<leader>hp", gs.preview_hunk, "[H]unk [P]review")
		map("n", "<leader>hd", gs.diffthis,     "[H]unk [D]iff")
		map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "[H]unk [B]lame")
		-- Visual: stage/reset selected lines
		map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "[H]unk [S]tage")
		map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "[H]unk [R]eset")
		-- Text object: 'ih' selects the hunk
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select hunk")
	end,
}

return M
