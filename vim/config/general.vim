"==========================================
" general.vim 基础设置
"==========================================

" Vim 8 defaults
unlet! skip_defaults_vim
silent! source $VIMRUNTIME/defaults.vim

augroup vimrc
	autocmd!
augroup END

let g:is_win = (has('win32') || has('win64')) ? v:true : v:false
let g:is_linux = (has('unix') && !has('macunix')) ? v:true : v:false
let g:is_mac = has('macunix') ? v:true : v:false

let mapleader      = ' '
let maplocalleader = ' '
let g:mapleader    = ' '

" 配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC
