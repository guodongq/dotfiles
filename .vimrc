" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
"            _____                    _____                    _____'
"           /\    \                  /\    \                  /\    \'
"          /::\____\                /::\    \                /::\____\'
"         /:::/    /                \:::\    \              /::::|   |'
"        /:::/    /                  \:::\    \            /:::::|   |'
"       /:::/    /                    \:::\    \          /::::::|   |'
"      /:::/____/                      \:::\    \        /:::/|::|   |'
"      |::|    |                       /::::\    \      /:::/ |::|   |'
"      |::|    |     _____    ____    /::::::\    \    /:::/  |::|___|______'
"      |::|    |    /\    \  /\   \  /:::/\:::\    \  /:::/   |::::::::\    \'
"      |::|    |   /::\____\/::\   \/:::/  \:::\____\/:::/    |:::::::::\____\'
"      |::|    |  /:::/    /\:::\  /:::/    \::/    /\::/    / ~~~~~/:::/    /'
"      |::|    | /:::/    /  \:::\/:::/    / \/____/  \/____/      /:::/    /'
"      |::|____|/:::/    /    \::::::/    /                       /:::/    /'
"      |:::::::::::/    /      \::::/____/                       /:::/    /'
"      \::::::::::/____/        \:::\    \                      /:::/    /'
"       ~~~~~~~~~~               \:::\    \                    /:::/    /'
"                                 \:::\    \                  /:::/    /'
"                                  \:::\____\                /:::/    /'
"                                   \::/    /                \::/    /'
"                                    \/____/                  \/____/'
"
"   This is the personal .vimrc file of Bruce.
"   While much of it is beneficial for general use, I would
"   recommend picking out the parts you want and understand.
"
"   You can find me at http://guodongq.github.io
"
"   Copyright 2024 Bruce
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