set nocompatible

" Set language
set langmenu=en_US
let $LANG="en_US"
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Set font to use in gvim
set guifont=Liberation\ Mono\ 12

" Set gvim gui options
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L

" Set encoding
set encoding=utf-8
set fileencodings=utf-8

" Automatic reload .vimrc
autocmd! bufwritepost .vimrc source %

" Better copy & paste
set pastetoggle=<F2>
set clipboard=unnamed

" mouse and backspace
set mouse=a
set bs=2

" Rebind <Leader> key
let mapleader=","

" Remove highlight fo the las search
noremap <Leader>, :nohl<CR>
vnoremap <Leader>, :nohl<CR>
inoremap <Leader>, :nohl<CR>

" map ctrl + <movement> to move around windows, instead of ctrl+w + <movement>
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Easier move between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" Map sort function to a key
vnoremap <Leader>s :sort<CR>

" Grep recursively in the project for the word under the cursor
" and show the results in a quickfix.
map <Leader>g :vimgrep /<C-R><C-W>/j **<CR>:copen<CR>

" show whitespaces
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" ColorScheme
color molokai
let g:rehash256 = 1
let g:molokai_original = 1

" Syntax highlight
filetype off
syntax on

" Showing line numbers and length
set number " show line numbers
set textwidth=79 " width of document (used by gd)
set nowrap " don't automatically wrap on load
set fo-=t " don't automatically wrap text when typing
set colorcolumn=80
highlight ColorColumn ctermbg=233
set cursorline

" easier formatting of paragraphs
vmap Q gq
nmap Q gqap

" Useful settings
set history=700
set undolevels=700

" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set autoindent
set expandtab

" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase

" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" Disable folding on opening
set nofoldenable

" Bind <C-c> as <Esc>
inoremap <C-c> <Esc><Esc>

" bind buffer navigation
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" Complete options (disable preview scratch window)
set completeopt=menu,menuone,longest

" Run current file
map <Leader>p :w<CR>:!clear && python %<CR>

" Map :make and run current file to a key
map <Leader>r :w<CR>:copen<CR>:make<CR><CR>


"======================
" Setup Plugins
"======================

" Setup Vundle to manage your plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Settings for lightline (vim-powerline fork)
Plugin 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'component': {
      \   'readonly': '%{&readonly?"x":""}',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }
set laststatus=2
set noshowmode

" Settings for ctrlp
Plugin 'kien/ctrlp.vim.git'
let g:ctrlp_max_height=30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*
set wildignore+=*/venv/*

" Settings snipmate
Plugin 'msanders/snipmate.vim.git'

" Settings surround.vim
Plugin 'tpope/vim-surround.git'

" Settings fugitive.vim, git for vim
Plugin 'tpope/vim-fugitive.git'

" Settings for NERDCommenter
Plugin 'scrooloose/nerdcommenter.git'

" Settings python-mode
Plugin 'klen/python-mode.git'
noremap <Leader>l :PymodeLintAuto<CR>
noremap <Leader>L :PymodeLint<CR>

call vundle#end()
filetype plugin indent on
