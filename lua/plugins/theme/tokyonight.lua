require('tokyonight').setup({
  style = 'night',
})

vim.cmd [[
try
  colorscheme tokyonight
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry
]]
