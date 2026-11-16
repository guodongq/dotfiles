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
