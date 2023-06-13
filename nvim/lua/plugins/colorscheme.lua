-- Colorscheme
vim.opt.termguicolors = true
vim.opt.background = 'dark' -- dark, light

-- Tokyonight
-- require('tokyonight').setup({
--   on_colors = function(colors)
--     colors.hint = colors.orange
--     colors.error = "#ff0000"
--   end
-- })
-- vim.cmd [[colorscheme tokyonight-storm]] -- tokyonight-day, tokyonight-moon, tokyonight-storm, tokyonight-night

-- Dracula
-- require('dracula').setup()
-- vim.cmd[[ colorscheme dracula]]

-- Gruvbox
-- require('gruvbox').setup()
-- vim.cmd[[ colorscheme gruvbox]]


-- Sakura
require('Sakura').load()
