--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Custom filetypes
vim.filetype.add({
	extension = {
		mdx = "markdown",
		mjml = "html",
		kicad_mod = "scheme",
	},
	filename = {
		["yup.lock"] = "yaml",
	},
})

-- Hide editor decorations in terminals, including ones opened in a hidden buffer
vim.api.nvim_create_autocmd({ "TermOpen", "BufWinEnter" }, {
	group = vim.api.nvim_create_augroup("term-open", { clear = true }),
	callback = function(event)
		if vim.bo[event.buf].buftype ~= "terminal" then
			return
		end
		vim.wo.number = false
		vim.wo.relativenumber = false
		vim.wo.signcolumn = "no"
		if event.event == "TermOpen" and vim.api.nvim_get_current_buf() == event.buf then
			vim.cmd.startinsert()
		end
	end,
})

-- Jump to the last place in the file before exiting
vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("buf-read-post", { clear = true }),
	callback = function(event)
		if vim.api.nvim_get_current_buf() ~= event.buf or vim.bo[event.buf].buftype ~= "" then
			return
		end
		local last_pos = vim.api.nvim_buf_get_mark(event.buf, '"')
		if last_pos[1] > 0 and last_pos[1] <= vim.api.nvim_buf_line_count(event.buf) then
			local line = vim.api.nvim_buf_get_lines(event.buf, last_pos[1] - 1, last_pos[1], false)[1]
			vim.api.nvim_win_set_cursor(0, { last_pos[1], math.min(last_pos[2], #line) })
		end
	end,
})

-- Relative line numbers: on in Normal, off in Insert to reduce distraction
vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
	group = vim.api.nvim_create_augroup("toggle-relative-number", { clear = true }),
	callback = function(event)
		if vim.bo[event.buf].buftype == "" then
			vim.wo.relativenumber = event.event == "InsertLeave"
		end
	end,
})
