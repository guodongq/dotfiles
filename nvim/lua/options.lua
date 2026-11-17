-- Set leaders before plugins load so their keymaps use them.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- No remote plugins: skip the Node.js, Perl, Python and Ruby providers.
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Appearance
vim.o.termguicolors = true
vim.o.number = true
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.breakindent = true
vim.o.scrolloff = 10

-- Editing
vim.o.mouse = "a"
vim.o.undofile = true
vim.o.confirm = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
-- The clipboard provider loads lazily on first register access (Nvim 0.11+).
vim.o.clipboard = "unnamedplus"

-- Prefer native providers; use Windows tools when WSL has no clipboard tool.
if vim.fn.has("wsl") == 1 and vim.g.clipboard == nil then
	local wayland = (vim.env.WAYLAND_DISPLAY or "") ~= ""
	local x11 = (vim.env.DISPLAY or "") ~= ""
	local native_clipboard = vim.fn.executable("win32yank.exe") == 1
		or (wayland and vim.fn.executable("wl-copy") == 1 and vim.fn.executable("wl-paste") == 1)
		or (x11 and (vim.fn.executable("xclip") == 1 or vim.fn.executable("xsel") == 1))
	if not native_clipboard and vim.fn.executable("clip.exe") == 1 and vim.fn.executable("powershell.exe") == 1 then
		local function copy(lines)
			-- clip.exe needs UTF-16LE for non-ASCII text.
			local text = vim.iconv(table.concat(lines, "\n"), "utf-8", "utf-16le")
			local result = vim.system({ "clip.exe" }, { stdin = text }):wait()
			assert(result.code == 0, result.stderr)
		end
		local paste = {
			"powershell.exe",
			"-NoLogo",
			"-NoProfile",
			"-NonInteractive",
			"-Command",
			"[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new($false); "
				.. '[Console]::Write(([string](Get-Clipboard -Raw)).Replace("`r`n", "`n"))',
		}
		vim.g.clipboard = {
			name = "WSL",
			copy = { ["+"] = copy, ["*"] = copy },
			paste = { ["+"] = paste, ["*"] = paste },
			cache_enabled = 0,
		}
	end
end

-- Search: ignore case unless the pattern contains capitals.
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = "split"

-- Windows and folds
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99 -- open all folds by default

-- Filetypes
vim.filetype.add({ extension = { mdx = "markdown" } })

-- Diagnostics
vim.diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },
	-- Show the diagnostic under the cursor after [d / ]d.
	jump = {
		on_jump = function(_, bufnr) vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false }) end,
	},
})
