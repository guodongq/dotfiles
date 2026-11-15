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

vim.api.nvim_create_autocmd("FileType", {
	desc = "Show native heading outlines on the right",
	group = group,
	pattern = "qf",
	callback = function()
		-- Nvim marks its heading outlines with this window variable.
		if not vim.w.qf_toc then
			return
		end
		vim.cmd.wincmd("L")
		local win = vim.api.nvim_get_current_win()
		local textoff = vim.fn.getwininfo(win)[1].textoff
		local width = 40
		-- Concealed quickfix prefixes still count towards wrapped line width.
		for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
			width = math.max(width, vim.fn.strdisplaywidth(line) + textoff)
		end
		vim.api.nvim_win_set_width(win, math.min(width, math.floor(vim.o.columns / 2)))
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	desc = "Start terminals in insert mode",
	group = group,
	callback = function(event)
		if event.buf == vim.api.nvim_get_current_buf() then
			vim.cmd.startinsert()
		end
	end,
})
