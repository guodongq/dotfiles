"==========================================
" mapping.vim 快捷键设置
"==========================================
" 在插入模式下输入两个jj进入普通模式下
inoremap jk <Esc>
xnoremap jk <Esc>
cnoremap jk <C-c>

noremap <C-F> <C-D>
noremap <C-B> <C-U>

" Open new line below and above current line
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

" 关闭方向键, 强迫自己用 hjkl
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

"se swap之后，同物理行上线直接跳
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" 分屏窗口移动, Smart way to move between windows
nnoremap <Leader>wh <C-W><C-H>
nnoremap <Leader>wj <C-W><C-J>
nnoremap <Leader>wk <C-W><C-K>
nnoremap <Leader>wl <C-W><C-L>

" buffer相关操作
nnoremap <leader>bn :bnext<cr>
nnoremap <leader>bp :bprev<cr>
nnoremap <leader>bd :bd<cr>
noremap <left> :bp<CR>
noremap <right> :bn<CR>


" Quickly save the current ile
inoremap <C-s> <C-O>:update<cr>
nnoremap <C-s> :update<cr>
nnoremap <leader>w :update<CR>


" split the windows
nnoremap <leader>v :vs<CR>
nnoremap <leader>s :sp<CR>

" tabline operation
nnoremap <leader>tn :tabn<cr>
nnoremap <leader>tp :tabp<cr>
nnoremap <leader>td :tabclose<cr>

" 关闭当前窗口以外的所有窗口
nnoremap <leader>wo  <C-W>o<CR>
" 关闭当前窗口
nnoremap <leader>q <C-W>q<CR>

nnoremap Y y$

" qq to record, Q to replay
nnoremap Q @q
nnoremap <S-tab> <c-w>W

" Quickfix when error
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz


" tab/s-tab circular windows navigation
nnoremap <tab> <c-w>w

noremap H ^
noremap L $


vnoremap <leader>y  "+y
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p

" autocmd
" 当文件准备存档之前删除每一行最后的空白
autocmd BufWritePre * :%s/\s\+$//e

" 将外部命令wmctrl控制窗口最大化的命令行参数封装成一个vim的函数
if executable('wmctrl')
    fun! ToggleFullscreen()
      call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")
    endf

    " 全屏开/关快捷键
    map <silent> <F11> :call ToggleFullscreen()<CR>
    " 启动vim时自动全屏
    autocmd VimEnter * call ToggleFullscreen()
  endif

