vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
	callback = function()
		vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]])
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Automatically close tab/vim when nvim-tree is the last window in the tab
-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
-- 	nested = true,
-- 	callback = function()
-- if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
-- vim.cmd("quit")
-- end
-- 	end,
-- })
vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		-- vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
		vim.highlight.on_yank({ higroup = "Visual" })
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.go", "*.c" },
	callback = function()
		vim.lsp.codelens.refresh()
	end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
	callback = function()
		vim.cmd("hi link illuminatedWord LspReferenceText")
	end,
})

-- vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
-- 	callback = function()
-- 		local line_count = vim.api.nvim_buf_line_count(0)
-- 		if line_count >= 5000 then
-- 			vim.cmd("IlluminatePauseBuf")
-- 		end
-- 	end,
-- })

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	callback = function()
		vim.opt.formatoptions = vim.opt.formatoptions
			- "o" -- O and o, don't continue comments
			+ "r" -- But do continue when pressing enter.
	end,
})

-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
-- 	pattern = { "*.go", "*.md", "*.sh", "*.lua" },
-- 	callback = function()
-- 		vim.lsp.buf.format({ async = true })
-- 	end,
-- })
