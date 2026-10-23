-- Loaded after plugins so filetype detection has already run in BufReadPost.
local function augroup(name) return vim.api.nvim_create_augroup(name, { clear = true }) end

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight yanked text",
	group = augroup("highlight-yank"),
	callback = function() vim.hl.on_yank() end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Restore the last cursor position",
	group = augroup("last-position"),
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

-- Nvim already hides line numbers and signs in terminals (see `:h terminal-config`).
vim.api.nvim_create_autocmd("TermOpen", {
	desc = "Start terminals in insert mode",
	group = augroup("terminal-insert"),
	callback = function(event)
		if event.buf == vim.api.nvim_get_current_buf() then
			vim.cmd.startinsert()
		end
	end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
	desc = "Relative line numbers only in Normal mode",
	group = augroup("relative-number"),
	callback = function(event)
		if vim.bo[event.buf].buftype == "" then
			vim.wo.relativenumber = event.event == "InsertLeave"
		end
	end,
})
