local M = {}

function M.desc(desc)
	local opts = M.opts()
	if desc and desc ~= "" then
		opts.desc = desc
	end
	return opts
end

function M.opts(opts)
	return vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
end

function M.map(mode, lhs, rhs, opts)
	vim.api.nvim_set_keymap(mode, lhs, rhs, M.opts(opts))
end

function M.buf_map(bufnr, mode, lhs, rhs, opts)
	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, M.opts(opts))
end

return M
