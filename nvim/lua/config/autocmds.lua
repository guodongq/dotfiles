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


-- Autocommands
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local misc_aucmds = augroup('misc_aucmds', { clear = true })

autocmd('BufWinEnter', { group = misc_aucmds, command = 'checktime' })

autocmd('TextYankPost', {
  group = misc_aucmds,
  callback = function()
    vim.highlight.on_yank()
  end,
})

autocmd('FileType', { group = misc_aucmds, pattern = 'qf', command = 'set nobuflisted' })

vim.cmd [[silent! autocmd! FileExplorer *]]

autocmd('BufEnter', {
  pattern = '*',
  callback = function(args)
    local file_info = vim.loop.fs_stat(args.file)
    if file_info and file_info.type == 'directory' then
      require('neo-tree').setup {}
      vim.cmd('Neotree position=current ' .. args.file)
    end
  end,
})
