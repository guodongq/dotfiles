# Nvim
🏡 It's personal, fully lua config on neovim

## 安装
```
mkdir -p ~/.config
git clone https://github.com/guodongq/nvim
```

## Prerequisites
- make
- g++
- luacheck

## 配置

- [可选参数](lua/settings.lua)
- [快捷键映射](lua/keybinds.lua)
- [自动命令](lua/autocmd.lua)
- [Packer插件管理](lua/plugins.lua)


## 插件配置

- LSP
    - [自动补全](lua/plugins/completion/cmp.lua)
    - [LSP client配置](lua/plugins/completion/lsp.lua)
    - [Snip代码片段](lua/plugins/completion/luasnip.lua)
    - [LSP server安装](lua/plugins/completion/mason.lua)
    - [Formatting&&Lint](lua/plugins/completion/null-ls.lua)
    - [自动匹配括号](lua/plugins/completion/pairs.lua)
    - [显示文档大纲](Symbols-Outline.lua)

- Editor
    - [Git](lua/plugins/editor/gitsigns.lua)
    - [跳转](lua/plugins/editor/hop.lua)
    - [友好的代码展示Indent](lua/plugins/editor/indentline.lua)
    - [注释](Comment.lua)

- Helper
    - [启动界面Dashboard](lua/plugins/helper/alpha.lua)
    - [模糊查找](lua/plugins/helper/telescope.lua)
    - [项目管理](Telescope Project.lua)
    - [命令行](lua/plugins/helper/toggleterm.lua)
    - [语法管理](lua/plugins/helper/treesitter.lua)
    - [快捷键](lua/plugins/helper/which-key.lua)

- Layout
    - [Buffer](lua/plug/bufferline.lua)
    - [状态栏](lua/plug/lualine.lua)
