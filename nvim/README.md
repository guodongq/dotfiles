# Nvim

Fully lua config on neovim

## Prerequisites

- make
- g++
- [luacheck](https://github.com/mpeterv/luacheck)
- [prettierd](https://github.com/fsouza/prettierd)

## 配置

- [可选参数](lua/settings.lua)
- [快捷键映射](lua/keymaps.lua)
- [自动命令](lua/autocmds.lua)
- [Packer 插件管理](lua/plugins.lua)

## 插件配置

- LSP

  - [Snip 代码片段](lua/plugins/lsp/luasnip.lua)
  - [LSP server 安装](lua/plugins/lsp/mason.lua)
  - [Formatting&&Lint](lua/plugins/lsp/null-ls.lua)
  - [自动补全](lua/plugins/lsp/nvim-cmp.lua)
  - [LSP client 配置](lua/plugins/lsp/servers.lua)
  - [自动匹配括号](lua/plugins/pairs.lua)

- [Buffer](lua/plugins/bufferline.lua)
- [注释](lua/plugins/comment.lua)
- [Debugger 调试](lua/plugins/dap.lua)
- [启动界面 Dashboard](lua/plugins/dashboard.lua)
- [比较](lua/plugins/diffview.lua)
- [Git Message](lua/plugins/git-messenger.lua)
- [跳转](lua/plugins/hop.lua)
- [友好的代码展示 Indent](lua/plugins/indentline.lua)
- [状态栏](lua/plugins/lualine.lua)
- [窗口最大化](lua/plugins/maximizer.lua)
- [导航窗格](lua/plugins/navigator.lua)
- [目录树](lua/plugins/nvim-tree.lua)
- [括号自动匹配](lua/plugins/pairs.lua)
- [模糊查找](lua/plugins/telescope.lua)
- [命令行](lua/plugins/toggleterm.lua)
- [语法管理](lua/plugins/treesitter.lua)
- [快捷键](lua/plugins/which-key.lua)
- [窗口选择](lua/plugins/window-picker.lua)
