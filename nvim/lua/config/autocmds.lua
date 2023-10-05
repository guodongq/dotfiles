local A = vim.api
local au = A.nvim_create_augroup('vimrc_', {clear=true})

-- Highlight the region on yank
A.nvim_create_autocmd('TextYankPost', {
  group = au,
  callback = function()
    vim.highlight.on_yank({higroup = 'Visual'})
  end,
})

-- Jump to the last place in the file before exiting
A.nvim_create_autocmd('BufReadPost', {
  group = au,
  callback = function(data)
    local last_pos = A.nvim_buf_get_mark(data.buf, '"')
    if last_pos[1] > 0 and last_pos[1] <= A.nvim_buf_line_count(data.buf) then
      A.nvim_win_set_cursor(0, last_pos)
    end
  end,
})
