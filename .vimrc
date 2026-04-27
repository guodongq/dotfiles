" Minimal .vimrc — standalone vim configuration (no plugins)
" For full IDE experience, use Neovim with ~/.config/nvim

" General
set nocompatible
filetype plugin indent on
syntax on
scriptencoding utf-8

let mapleader = ' '
let maplocalleader = ' '

set mouse=a
set hidden
set history=1000
set shortmess+=filmnrxoOtT
set backspace=indent,eol,start

if has('clipboard')
  set clipboard=unnamed,unnamedplus
endif

" UI
set number
set cursorline
set showmatch
set showmode
set showcmd
set laststatus=2
set wildmenu
set wildmode=list:longest,full
set scrolloff=3
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

" Search
set incsearch
set hlsearch
set ignorecase
set smartcase

" Formatting
set autoindent
set shiftwidth=4
set expandtab
set tabstop=4
set softtabstop=4
set nowrap
set nojoinspaces
set splitright
set splitbelow

" Colorscheme
set background=dark
if has('termguicolors')
  set termguicolors
endif

" Key Mappings
nnoremap <silent> <leader>H :nohlsearch<CR>
nnoremap <leader>Q :confirm qall<CR>
nnoremap <leader>S :w!<CR>
nnoremap <Esc> :nohlsearch<CR>

noremap j gj
noremap k gk
vnoremap < <gv
vnoremap > >gv

nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h
nnoremap <leader>wd :wincmd c<CR>
nnoremap <leader>wD :wincmd o<CR>
nnoremap <leader>ws :sp<CR>
nnoremap <leader>wv :vsp<CR>

nnoremap <S-l> :bnext<CR>
nnoremap <S-h> :bprevious<CR>

" File explorer (netrw)
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 25
nnoremap <leader>e :Lexplore<CR>
