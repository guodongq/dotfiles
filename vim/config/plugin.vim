" ==========================================
" bundle 插件管理和配置项
" ==========================================

" ################### 包依赖 #####################
" package dependence:  ctags, ag(he_silver_searcher)
" python dependence:   pep8, pyflake
" golang dependence:   go
" lsp dependence:      nodejs


" ################### 插件管理 ###################
" inspired by spf13, 自定义需要的插件集合
if !exists('g:bundle_groups')
    " let g:bundle_groups=['python', 'javascript', 'golang', 'php', 'ruby', 'shell', 'markdown', 'html', 'css', 'less', 'coffeescript', 'tmux', 'json', 'beta', 'devicons']
    let g:bundle_groups=['golang', 'shell', 'json']
endif

" ----------------------------------------------------------------------------
" 使用 vim-plug 管理插件
" ----------------------------------------------------------------------------
silent!  if plug#begin(g:home.'/plugged')

" fctx
Plug 'ybian/smartim'

" async syntax checking plugin for Vim
Plug 'w0rp/ale', {'tag': 'b934dc5'}

" Highlights trailing whitespace in red and provides
Plug 'bronson/vim-trailing-whitespace'

" nerdtree nerdtreetabs
Plug 'preservim/nerdtree' | Plug 'jistr/vim-nerdtree-tabs'

" vim windows max
Plug 'szw/vim-maximizer'

" tagbar
Plug 'majutsushi/tagbar'

" 主题 gruvbox
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'NLKNguyen/papercolor-theme'
Plug 'altercation/vim-colors-solarized'


" 括号匹配
Plug 'jiangmiao/auto-pairs'

" 开始启动
Plug 'mhinz/vim-startify'

" 窗口切换
Plug 't9md/vim-choosewin',  { 'on': 'ChooseWin' }

" 补全
"Plug 'ycm-core/YouCompleteMe'

" 快速注释
Plug 'scrooloose/nerdcommenter'

"  模糊查找
Plug 'ctrlpvim/ctrlp.vim'

" 全局搜索
Plug 'mileszs/ack.vim'

" 快速跳转
Plug 'easymotion/vim-easymotion'

" 代码缩进层次
Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesEnable' }
Plug 'godlygeek/tabular'


" Adds file type icons to Vim plugins
if count(g:bundle_groups, 'devicons')
    " 状态栏增强展示
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'ryanoasis/vim-devicons'
endif


" golang
if count(g:bundle_groups, 'golang')
    " 1. vim a.go
    " 2. :GoInstallBinaries
    " vimgo  https://github.com/fatih/vim-go
    Plug 'fatih/vim-go', {'for': 'go'}
endif

" tmux
if count(g:bundle_groups, 'tmux')
    " tmux
    " For tmux navigator Ctrl-hjkl
    Plug 'christoomey/vim-tmux-navigator'
endif

" markdown
Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app && yarn install'}

call plug#end()
endif
