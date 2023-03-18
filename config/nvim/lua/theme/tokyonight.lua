require('tokyonight').setup({
    style = 'night', --night,day,moon,storm
    light_style = 'light',  -- day,light
})

vim.cmd [[
try
  colorscheme tokyonight
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry
]]
