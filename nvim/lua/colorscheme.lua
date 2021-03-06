vim.opt.background = "dark"

-- tokyonight
vim.g.tokyonight_style = "" --night, day
local colorscheme = "tokyonight"

-- gruvbox
-- local colorscheme = "gruvbox"
-- local status_ok, gruvbox = pcall(require, "gruvbox")
-- if not status_ok then
--   return
-- end
--
-- gruvbox.setup({
--   undercurl = true,
--   underline = true,
--   bold = true,
--   italic = true,
--   strikethrough = true,
--   invert_selection = false,
--   invert_signs = false,
--   invert_tabline = false,
--   invert_intend_guides = false,
--   inverse = true, -- invert background for search, diffs, statuslines and errors
--   contrast = "", -- can be "hard", "soft" or empty string
--   overrides = {
--       SignColumn = {bg = "#ff9900"}
--   },
-- })

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end


