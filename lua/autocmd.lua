local myAutoGroup = vim.api.nvim_create_augroup("myAutoGroup", {
  clear = true,
})

local autocmd = vim.api.nvim_create_autocmd

-- Highlight the region on yank
autocmd('TextYankPost', {
    group = myAutoGroup,
    callback = function()
        vim.highlight.on_yank({ higroup = 'HighLightLineMatches', timeout = 200 })
    end,
    pattern = '*',
})
-- Do not add comments when use o add a new line
autocmd('BufEnter',{
    group = myAutoGroup,
    pattern = '*',
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions
        - "o" -- O and o, don't continue comments
        + "r" -- But do continue when pressing enter.
    end,
})
