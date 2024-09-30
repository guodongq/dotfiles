" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
" This is the personal .vimrc file of Bruce Qian. While much of it is
" beneficial for general use, I would recommend picking out the parts you
" want and understand.
"
" You can find me at http://guodongq.github.io
"
" Copyright 2014 Bruce Qian
"
" Licensed under the Apache License, Version 2.0 (the "License"); you may
" not use this file except in compliance with the License. You may obtain a
" copy of the License at
"
"     http://www.apache.org/licenses/LICENSE-2.0
"
" Unless required by applicable law or agreed to in writing, software
" distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
" WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
" License for the specific language governing permissions and limitations
" under the License.
" }

" Environment {
    " Identify platform {
        silent function! OSX()
            return has('macunix')
        endfunction
        silent function! LINUX()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction
        silent function! WINDOWS()
            return  (has('win32') || has('win64'))
        endfunction
    " }

    " Basics {
            set nocompatible        " Must be first line
            if !WINDOWS()
                set shell=/bin/sh
            endif
    " }

    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if WINDOWS()
            set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }

    " Arrow Key Fix {
        " https://github.com/spf13/spf13-vim/issues/780
        if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
            inoremap <silent> <C-[>OC <RIGHT>
        endif
    " }
" }

" Bundles {
    " Setup Bundle support {
        filetype off
        set rtp+=~/.vim/bundle/Vundle.vim
        call vundle#begin()
    " }

    " Deps {
        " let Vundle manage Vundle, required
        Bundle 'VundleVim/Vundle.vim'
        Bundle 'MarcWeber/vim-addon-mw-utils'
        Bundle 'tomtom/tlib_vim'
        if executable('ag')
            Bundle 'mileszs/ack.vim'
            let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'
        elseif executable('ack-grep')
            let g:ackprg="ack-grep -H --nocolor --nogroup --column"
            Bundle 'mileszs/ack.vim'
        elseif executable('ack')
            Bundle 'mileszs/ack.vim'
        endif
    " }

    " list only the plugin groups you will use
    if !exists('g:bundle_groups')
        let g:bundle_groups = [
            \ 'general',
            \ 'writing',
            \ 'neocomplete',
            \ 'programming',
            \ 'python',
            \ 'javascript',
            \ 'html',
            \ 'go',
            \ ]
    endif

    " General {
        if count(g:bundle_groups, 'general')
            Bundle 'scrooloose/nerdtree'
            Bundle 'morhetz/gruvbox'
            Bundle 'liuchengxu/vim-which-key'
        endif
    " }

    " Golang {
        if count(g:bundle_groups, 'go')
            Bundle 'fatih/vim-go'
        endif
    " }

    " Finish Bundle support {
        call vundle#end()
        filetype plugin indent on
    " }
" }

" General {
    " Leader key {
    if !exists('g:leader')
        let mapleader = ' '
    else
        let mapleader=g:leader
    endif
    if !exists('g:localleader')
        let maplocalleader = ' '
    else
        let maplocalleader=g:localleader
    endif
    " }


    " Which-Key {
    if isdirectory(expand("~/.vim/bundle/vim-which-key"))
        nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
        vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
        let g:which_key_map = {}
        let g:which_key_map.b = {
            \ 'name' : '+[B]uffer',
            \ 'a': '[D]elete [A]ll Buffers',
            \ 'd': '[D]elete Current Buffer',
            \ 'D': '[D]elete Other Buffers',
            \ 'g': 'Trigger back[g]round color',
            \ 'n': '[N]ext Buffer',
            \ 'p': '[P]revious Buffer',
            \ 'l': '[L]ist Buffers',
            \ }
        let g:which_key_map.f = '[F]ormat buffer'
        let g:which_key_map.e = 'Toggle [E]xplorer'
        let g:which_key_map.H = 'Clear [H]ighlights'
        let g:which_key_map.S = '[S]ave file'
        let g:which_key_map.Q = '[Q]uit Vim'
        let g:which_key_map.w = {
            \ 'name' : '+[W]orkspace',
            \ 'd': '[D]elete Current [W]indow',
            \ 'D': '[D]elete Other [W]indows',
            \ 's': '[S]plit [W]indow',
            \ 'v': 'Split [W]indow [V]ertically',
            \ }

        call which_key#register('<Space>', "g:which_key_map")
    endif
    " }

    " Allow to trigger background
    function! ToggleBG()
        let s:tbg = &background
        if s:tbg == "dark"
            set background=light
        else
            set background=dark
        endif
    endfunction
    map <silent> <leader>bg :call ToggleBG()<CR>

    filetype plugin indent on "Automatically detect file types
    syntax on " Syntax highlighting
    set mouse=a  " Automatically enable mouse usage
    set mousehide "Hide the mouse cursor while typing
    scriptencoding utf-8

    if has('clipboard')
        if has('unnamedplus') " When possible use + register for copy-paste 
            set clipboard=unnamed,unnamedplus
        else  " On mac and windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif

    " Most prefer to automatically switch to the current file directory when
    " a new buffer is opened; to prevent this behavior, add the following to
    " your .vimrc file:
    "   let g:no_autochdir = 1
    if !exists('g:no_autochdir')
        autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
        " Always switch to the current file directory
    endif

    "set autowrite                       " Automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
    set spell                           " Spell checking on
    set hidden                          " Allow buffer switching without saving
    set iskeyword-=.                    " '.' is an end of word designator
    set iskeyword-=#                    " '#' is an end of word designator
    set iskeyword-=-                    " '-' is an end of word designator
" }

" Vim UI {
    if filereadable(expand("~/.vim/bundle/gruvbox/colors/gruvbox.vim"))
    set background=dark
    color gruvbox
    endif

     set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode

    set cursorline                  " Highlight current line

    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode
    "highlight clear CursorLineNr    " Remove highlight color from current line number
    
    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

      set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set number                      " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
" }

" Formatting {
    set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    "set matchpairs+=<:>             " Match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
" }

" Key (re)Mappings {
    nmap <silent> <leader>H :nohlsearch<CR>
    nmap <leader>Q :confirm qall<CR>
    nmap <leader>S :w!<CR>

    nmap <Esc> :nohlsearch<CR>
    imap jk :<Esc><CR>

    " Easier moving in tabs and windows
    " The lines conflict with the default digraph mapping of <C-K>
    " If you prefer that functionality, add the following to your
    " .vimrc file:
    "   let g:no_easyWindows = 1
    if !exists('g:no_easyWindows')
        map <C-J> <C-W>j<C-W>_
        map <C-K> <C-W>k<C-W>_
        map <C-L> <C-W>l<C-W>_
        map <C-H> <C-W>h<C-W>_
    endif

    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk

    nmap <leader>wd :wincmd c<CR>
    nmap <leader>wD :wincmd o<CR>
    nmap <leader>ws :sp<CR>
    nmap <leader>wv :vsp<CR>

    nmap <S-l> :bnext<CR>
    nmap <S-h> :bprevious<CR>

     " Visual shifting (does not exit Visual mode)
     vnoremap < <gv
     vnoremap > >gv

     " Easier formatting
     nnoremap <silent> <leader>f gwip
" }

" Plugins {
    " NerdTree {
    if isdirectory(expand("~/.vim/bundle/nerdtree"))
        nmap <leader>e :NERDTreeToggle<CR>

        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
        let NERDTreeChDirMode=0
        let NERDTreeQuitOnOpen=1
        let NERDTreeMouseMode=2
        let NERDTreeShowHidden=1
        let NERDTreeKeepTreeInNewTab=1
        let g:nerdtree_tabs_open_on_gui_startup=0
    endif
    " }
" }
