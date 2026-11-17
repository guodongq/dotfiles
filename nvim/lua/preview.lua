-- Browser previews: Markdown through mpls, notebooks through JupyterLab.
local M = {}
local labs = {} -- one JupyterLab per project root: { file = notebook to show, base/query = URL parts once ready }

local function warn(message) vim.notify(message, vim.log.levels.WARN, { title = "Preview" }) end

local function show_notebook(root, lab)
	local path = vim.uri_encode(vim.fs.relpath(root, lab.file)) -- keeps "/"
	local _, err = vim.ui.open(lab.base .. "/tree/" .. path .. lab.query)
	if err then
		warn(err)
	end
end

local function preview_notebook(file)
	if vim.bo.modified or vim.fn.filereadable(file) == 0 then
		return warn("Save the notebook first")
	elseif vim.fn.executable("jupyter") == 0 then
		return warn("Notebook preview needs JupyterLab: brew install jupyterlab")
	end
	local root = vim.fs.root(file, ".git") or vim.fs.dirname(file)
	local lab = labs[root]
	if lab then -- reuse it; while it is starting, it shows the latest notebook once ready
		lab.file = file
		if lab.base then
			show_notebook(root, lab)
		end
		return
	end
	lab = { file = file }
	labs[root] = lab
	local output = ""
	-- Stops with Neovim. Ready once it logs its URL, e.g. http://127.0.0.1:8888/lab?token=abc
	vim.fn.jobstart({ "jupyter", "lab", "--no-browser", "--ip=127.0.0.1" }, {
		cwd = root,
		on_stderr = function(_, data)
			if not lab.base then
				output = output .. table.concat(data, "\n")
				lab.base, lab.query = output:match("(http://127%.0%.0%.1:%d+%S*/lab)(%S*)%s")
				if lab.base then
					show_notebook(root, lab)
				end
			end
		end,
		on_exit = function(_, code)
			labs[root] = nil
			if not lab.base then
				warn(("JupyterLab exited with code %d; try `jupyter lab` in a terminal"):format(code))
			end
		end,
	})
end

function M.open()
	local buf = vim.api.nvim_get_current_buf()
	local file = vim.api.nvim_buf_get_name(buf)
	if file:match("%.ipynb$") then
		return preview_notebook(file)
	end
	local mpls = vim.lsp.get_clients({ bufnr = buf, name = "mpls" })[1]
	if not mpls then
		return warn("Preview works for notebooks and Markdown files with mpls attached")
	end
	local uri = vim.uri_from_bufnr(buf)
	mpls:exec_cmd({ title = "Preview", command = "open-preview" }, { bufnr = buf }, function(err)
		if err then
			return warn("Markdown preview failed: " .. err.message)
		end
		-- mpls opens the most recently edited document; show this one.
		mpls:notify("mpls/editorDidChangeFocus", { uri = uri })
	end)
end

-- Marksman's code action creates or updates the table of contents.
function M.toc()
	vim.lsp.buf.code_action({
		apply = true,
		filter = function(action) return action.title:lower():find("table of contents", 1, true) ~= nil end,
	})
end

return M
