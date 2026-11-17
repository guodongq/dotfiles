local group = vim.api.nvim_create_augroup("dotfiles", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight yanked text",
	group = group,
	callback = function() vim.hl.on_yank() end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Restore the last cursor position",
	group = group,
	callback = function(event)
		local buf = event.buf
		if buf ~= vim.api.nvim_get_current_buf() or vim.bo[buf].buftype ~= "" then
			return
		end
		-- Commit and rebase messages reuse the same file; always start at the top.
		if vim.list_contains({ "gitcommit", "gitrebase" }, vim.bo[buf].filetype) then
			return
		end
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(buf) then
			vim.api.nvim_win_set_cursor(0, mark)
		end
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	desc = "Start bare terminals in insert mode (Snacks handles its own)",
	group = group,
	callback = function(event)
		if event.buf == vim.api.nvim_get_current_buf() then
			vim.cmd.startinsert()
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "Show location lists, like the gO outline, on the right; q closes list windows",
	group = group,
	pattern = "qf",
	callback = function(event)
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, desc = "Close list" })
		local win = vim.api.nvim_get_current_win()
		-- FileType fires again whenever the list refreshes; move each window once, keeping manual resizes.
		if vim.fn.win_gettype(win) == "loclist" and not vim.w[win].sidebar then
			vim.w[win].sidebar = true
			vim.cmd.wincmd("L")
			vim.api.nvim_win_set_width(win, 40)
			vim.wo[win].winfixwidth = true
		end
	end,
})
