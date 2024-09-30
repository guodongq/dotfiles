" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
"   This is the personal .vimrc file of Bruce Qian.
"   While much of it is beneficial for general use, I would
"   recommend picking out the parts you want and understand.
"
"   You can find me at http://guodongq.github.io
"
"   Copyright 2014 Bruce Qian
"
"   Licensed under the Apache License, Version 2.0 (the "License");
"   you may not use this file except in compliance with the License.
"   You may obtain a copy of the License at
"
"       http://www.apache.org/licenses/LICENSE-2.0
"
"   Unless required by applicable law or agreed to in writing, software
"   distributed under the License is distributed on an "AS IS" BASIS,
"   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
"   See the License for the specific language governing permissions and
"   limitations under the License.
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
        let g:which_key_map.e = 'Toggle [E]xplorer'
        let g:which_key_map.H = 'Clear [H]ighlights'
        let g:which_key_map.S = '[S]ave file'
        let g:which_key_map.Q = '[Q]uit Vim'

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
" }

" Vim UI {
    if filereadable(expand("~/.vim/bundle/gruvbox/colors/gruvbox.vim"))
    set background=dark
    color gruvbox
    endif
" }

" Key (re)Mappings {
    noremap <leader>H :nohlsearch<CR>
    noremap <leader>Q :confirm qall<CR>
    noremap <leader>S :w!<CR>
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
