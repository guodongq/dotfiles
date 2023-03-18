# Nvim

Fully lua config on neovim

## Prerequisites

- make
- g++
- [luacheck](https://github.com/mpeterv/luacheck)
- [prettierd](https://github.com/fsouza/prettierd)

## 配置

- [可选参数](lua/option.lua)
- [快捷键映射](lua/keymap.lua)
- [自动命令](lua/autocmd.lua)
- [Packer 插件管理](lua/plugin.lua)

## 插件配置

- LSP

    - [Snip 代码片段](lua/plugin/lsp/luasnip.lua)
    - [LSP server 安装](lua/plugin/lsp/mason.lua)
    - [Formatting&&Lint](lua/plugin/lsp/null-ls.lua)
    - [自动补全](lua/plugin/lsp/nvim-cmp.lua)
    - [LSP client 配置](lua/plugin/lsp/servers.lua)
    - [自动匹配括号](lua/plugin/pairs.lua)

- [Buffer](lua/plugin/bufferline.lua)
- [注释](lua/plugin/comment.lua)
- [Debugger 调试](lua/plugin/dap.lua)
- [启动界面 Dashboard](lua/plugin/dashboard.lua)
- [比较](lua/plugin/diffview.lua)
- [Git Message](lua/plugin/git-messenger.lua)
- [跳转](lua/plugin/hop.lua)
- [友好的代码展示 Indent](lua/plugin/indentline.lua)
- [状态栏](lua/plugin/lualine.lua)
- [窗口最大化](lua/plugin/maximizer.lua)
- [导航窗格](lua/plugin/navigator.lua)
- [目录树](lua/plugin/nvim-tree.lua)
- [括号自动匹配](lua/plugin/pairs.lua)
- [模糊查找](lua/plugin/telescope.lua)
- [命令行](lua/plugin/toggleterm.lua)
- [语法管理](lua/plugin/treesitter.lua)
- [快捷键](lua/plugin/which-key.lua)
- [窗口选择](lua/plugin/window-picker.lua)
