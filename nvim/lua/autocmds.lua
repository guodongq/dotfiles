local myAutoGroup = vim.api.nvim_create_augroup("myAutoGroup", {
  clear = true,
})


-- nvim-tree close automatically when no buffers
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  group = myAutoGroup,
  callback = function ()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
      vim.cmd("quit")
    end
  end,
})

-- when enter terminal, go to insert mode directly
auvim.api.nvim_create_autocmd("TermOpen", {
  group = myAutoGroup,
  command = "startinsert",
})

-- when save file, format it automatically
vim.api.nvim_create_autocmd("BufWritePre", {
  group = myAutoGroup,
  pattern = { "*.lua", "*.py", "*.sh", "*.go", "*.c" },
  callback = vim.lsp.buf.formatting_sync
})

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

-- Don't comment when use o to start a new line
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd "set formatoptions-=cro"
  end,
})

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})