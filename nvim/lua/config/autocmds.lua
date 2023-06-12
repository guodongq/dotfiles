-- Custom filetypes
vim.filetype.add({
    extension = {
        conf = 'conf',
        mdx = 'markdown',
        mjml = 'html',
        kicad_mod = 'scheme',
        tfvars = 'terraform',
        yml = 'yaml'
    },
    pattern = {
        ['.*%.env.*'] = 'sh',
        ['ignore$'] = 'conf',
    },
    filename = {
        ['yup.lock'] = 'yaml',
    },
})

local function augroup(name)
  return vim.api.nvim_create_augroup("nvim_" .. name, { clear = true })
end

-- Remember last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup("remember_cursor"),
    pattern = "*",
    callback = function()
        local row, col = unpack(vim.api.nvim_buf_get_mark(0, '"'))
        if row > 0 and row <= vim.api.nvim_buf_line_count(0) then
            vim.api.nvim_win_set_cursor(0, { row, col })
        end
    end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("text_yank_post"),
    pattern = "*",
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Toggle highlighting current line only in active splits {{{1
vim.api.nvim_create_augroup('user_toggle_cursorline', { clear = true })
vim.api.nvim_create_autocmd({ 'VimEnter', 'WinEnter', 'BufWinEnter' }, {
  group = 'user_toggle_cursorline',
  desc = 'enable cursorline on focus',
  pattern = '*',
  callback = function()
    vim.opt_local.cursorline = true
  end,
})

vim.api.nvim_create_autocmd({ 'VimLeave', 'WinLeave', 'BufWinLeave' }, {
  group = 'user_toggle_cursorline',
  desc = 'disable cursorline on lost focus',
  pattern = '*',
  callback = function()
    vim.opt_local.cursorline = false
  end,
})
