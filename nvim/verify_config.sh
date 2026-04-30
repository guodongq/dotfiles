#!/bin/bash
# Neovim 配置验证脚本

echo "🔍 验证 Neovim 配置..."
echo ""

# 检查 LSP 配置
echo "📦 检查 LSP 配置..."
nvim --headless -c "luafile nvim/lua/plugins/lsp.lua" -c "quit" 2>&1
if [ $? -eq 0 ]; then
    echo "✅ LSP 配置: 正常"
else
    echo "❌ LSP 配置: 有错误"
    exit 1
fi
echo ""

# 检查格式化配置
echo "🎨 检查格式化配置..."
nvim --headless -c "luafile nvim/lua/plugins/formatting.lua" -c "quit" 2>&1
if [ $? -eq 0 ]; then
    echo "✅ 格式化配置: 正常"
else
    echo "❌ 格式化配置: 有错误"
    exit 1
fi
echo ""

# 检查 Lint 配置
echo "🔍 检查 Lint 配置..."
nvim --headless -c "luafile nvim/lua/plugins/lint.lua" -c "quit" 2>&1
if [ $? -eq 0 ]; then
    echo "✅ Lint 配置: 正常"
else
    echo "❌ Lint 配置: 有错误"
    exit 1
fi
echo ""

# 测试插件加载
echo "🔌 测试插件加载..."
nvim --headless -c "lua require('plugins.lsp')" -c "quit" 2>&1
if [ $? -eq 0 ]; then
    echo "✅ 插件加载: 正常"
else
    echo "❌ 插件加载: 有错误"
    exit 1
fi
echo ""

echo "🎉 所有配置验证通过！"
echo ""
echo "💡 提示: 使用 :Mason 手动安装缺失的工具"
