local A = vim.api

-- Custom filetypes
vim.filetype.add({
  extension = {
    conf = 'conf',
    mdx = 'markdown',
    mjml = 'html',
    kicad_mod = 'scheme',
  },
  pattern = {
    ['.*%.env.*'] = 'sh',
    ['ignore$'] = 'conf',
  },
  filename = {
    ['yup.lock'] = 'yaml',
  },
})

local num_au = A.nvim_create_augroup('NUMTOSTR', { clear = true })

-- Highlight the region on yank
A.nvim_create_autocmd('TextYankPost', {
  group = num_au,
  callback = function()
    vim.highlight.on_yank({ higroup = 'Visual' })
    -- This is a workaround for clipboard not working in WSL
    -- see https://github.com/neovim/neovim/issues/19204#issuecomment-1173722375
    -- if vim.fn.has('wsl') == 1 then
    --     vim.fn.system('clip.exe', vim.fn.getreg('"'))
    -- end
  end,
})

-- Jump to the last place in the file before exiting
A.nvim_create_autocmd('BufReadPost', {
  group = num_au,
  callback = function(data)
    local last_pos = A.nvim_buf_get_mark(data.buf, '"')
    if last_pos[1] > 0 and last_pos[1] <= A.nvim_buf_line_count(data.buf) then
      A.nvim_win_set_cursor(0, last_pos)
    end
  end,
})

-- show cursor line only in active window
A.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
  callback = function()
    local ok, cl = pcall(A.nvim_win_get_var, 0, 'auto-cursorline')
    if ok and cl then
      vim.wo.cursorline = true
      A.nvim_win_del_var(0, 'auto-cursorline')
    end
  end,
})
A.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      A.nvim_win_set_var(0, 'auto-cursorline', cl)
      vim.wo.cursorline = false
    end
  end,
})
