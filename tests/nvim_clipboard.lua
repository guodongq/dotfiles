local root = assert(arg[1], "repository root required")
local mode = assert(arg[2], "clipboard environment required")
local has, executable = vim.fn.has, vim.fn.executable

-- Simulate platform/tool availability; clipboard commands are temporary stubs.
vim.fn.has = function(feature)
	if feature == "wsl" then
		return mode == "macos" and 0 or 1
	end
	return has(feature)
end
vim.fn.executable = function(command)
	if command == "clip.exe" or command == "powershell.exe" then
		return mode == "missing" and 0 or 1
	end
	if mode == "win32yank" and command == "win32yank.exe" then
		return 1
	end
	if (mode == "wayland" or mode == "headless") and (command == "wl-copy" or command == "wl-paste") then
		return 1
	end
	if (mode == "x11" or mode == "headless") and command == "xclip" then
		return 1
	end
	return 0
end
vim.env.WAYLAND_DISPLAY = mode == "wayland" and "test-wayland" or nil
vim.env.DISPLAY = mode == "x11" and ":test" or nil
if mode == "headless" then
	vim.env.WAYLAND_DISPLAY, vim.env.DISPLAY = "", ""
end
if mode == "custom" then
	vim.g.clipboard = "osc52"
end
dofile(root .. "/nvim/lua/options.lua")
vim.fn.has, vim.fn.executable = has, executable

if mode == "command" then
	io.stdout:write(vim.json.encode(vim.g.clipboard.paste["+"]))
	return
end

if mode ~= "wsl" and mode ~= "headless" then
	local expected = mode == "custom" and "osc52" or nil
	assert(vim.g.clipboard == expected, "Existing clipboard detection should be preserved: " .. mode)
	return
end

assert(vim.fn.has("clipboard") == 1, "WSL clipboard provider did not load")
local text = "Clipboard: "
	.. vim.fn.nr2char(0x4E2D)
	.. vim.fn.nr2char(0x6587)
	.. vim.fn.nr2char(0x1F680)
	.. "\nsecond line"
for _, register in ipairs({ "+", "*" }) do
	for _, regtype in ipairs({ "v", "V" }) do
		local value = text .. (regtype == "V" and "\n" or "")
		vim.fn.setreg(register, value, regtype)
		assert(io.open(vim.env.HOME .. "/clipboard", "rb")):close()
		assert(vim.fn.getreg(register) == value, "Clipboard changed Unicode text or trailing newlines")
		assert(vim.fn.getregtype(register) == regtype, "Clipboard changed the selection type")
	end
end

local windows_text = text .. "\nfrom Windows\n"
local file = assert(io.open(vim.env.HOME .. "/clipboard", "wb"))
file:write(vim.iconv(windows_text:gsub("\n", "\r\n"), "utf-8", "utf-16le"))
file:close()
assert(vim.fn.getreg("+") == windows_text, "Windows line endings were not normalized")
