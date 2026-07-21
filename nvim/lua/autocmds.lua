--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function() vim.hl.on_yank() end,
})

-- Custom filetypes
vim.filetype.add({
	extension = {
		conf = "conf",
		mdx = "markdown",
		mjml = "html",
		kicad_mod = "scheme",
	},
	pattern = {
		[".*%.env.*"] = "sh",
		["ignore$"] = "conf",
	},
	filename = {
		["yup.lock"] = "yaml",
	},
})

-- Remove useless stuff from the terminal window and enter INSERT mode
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("term-open", { clear = true }),
	callback = function(data)
		if not string.find(vim.bo[data.buf].filetype, "^[fF][tT]erm") then
			vim.api.nvim_set_option_value("number", false, { scope = "local" })
			vim.api.nvim_set_option_value("relativenumber", false, { scope = "local" })
			vim.api.nvim_set_option_value("signcolumn", "no", { scope = "local" })
			vim.api.nvim_command("startinsert")
		end
	end,
})

-- Jump to the last place in the file before exiting
vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("buf-read-post", { clear = true }),
	callback = function(data)
		local last_pos = vim.api.nvim_buf_get_mark(data.buf, '"')
		if last_pos[1] > 0 and last_pos[1] <= vim.api.nvim_buf_line_count(data.buf) then
			vim.api.nvim_win_set_cursor(0, last_pos)
		end
	end,
})