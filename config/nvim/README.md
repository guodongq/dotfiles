# Nvim

Fully lua config on neovim

## Prerequisites

- make
- g++
- [luacheck](https://github.com/mpeterv/luacheck)
- [prettierd](https://github.com/fsouza/prettierd)

## 配置

- [内置参数](lua/user/builtins.lua)
- [可选参数](lua/user/options.lua)
- [快捷键映射](lua/user/keymaps.lua)
- [自动命令](lua/lua/autocmds.lua)
- [Packer 插件管理](lua/user/plugins.lua)

## 插件配置

- LSP

  - [Snip 代码片段](lua/user/plugins/lsp/luasnip.lua)
  - [LSP server 安装](lua/user/plugins/lsp/mason.lua)
  - [Formatting&&Lint](lua/user/plugins/lsp/null-ls.lua)
  - [自动补全](lua/user/plugins/lsp/cmp.lua)
  - [LSP client 配置](lua/user/plugins/lsp/servers.lua)
  - [自动匹配括号](lua/plugins/completion/pairs.lua)

- [Buffer](lua/user/plugins/bufferline.lua)
- [注释](lua/user/plugins/Comment.lua)
- [Debugger 调试](lua/user/plugins/dap.lua)
- [启动界面 Dashboard](lua/user/plugins/dashboard.lua)
- [比较](lua/user/plugins/diffview.lua)
- [Git Message](lua/user/plugins/git-messenger.lua)
- [跳转](lua/user/plugins/hop.lua)
- [友好的代码展示 Indent](lua/user/plugins/indentline.lua)
- [状态栏](lua/user/plugins/lualine.lua)
- [窗口最大化](lua/user/plugins/maximizer.lua)
- [导航窗格](lua/user/plugins/navigator.lua)
- [目录树](lua/user/plugins/nvim-tree.lua)
- [括号自动匹配](lua/user/plugins/pairs.lua)
- [模糊查找](lua/user/plugins/telescope.lua)
- [命令行](lua/user/plugins/toggleterm.lua)
- [语法管理](lua/user/plugins/treesitter.lua)
- [快捷键](lua/user/plugins/which-key.lua)
- [窗口选择](lua/user/plugins/window-picker.lua)
