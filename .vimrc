set nocompatible
filetype off

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
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" curl -so wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
" set t_Co=256
" color wombat256mod
color molokai
let g:rehash256 = 1
" let g:molokai_original = 1

" Syntax highlight
filetype off
filetype plugin indent on
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

" Setup Pathogen to manage your plugins
" mkdir -p ~/.vim/autoload ~/.vim/bundle
" curl -so ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
" Now you can install any plugin into a .vim/bundle/plugin-name/ folder
call pathogen#infect()
call pathogen#helptags()

" Settings for lightline (vim-powerline fork)
" cd ~/.vim/bundle
" git clone https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'component': {
      \   'readonly': '%{&readonly?"x":""}',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }
set laststatus=2
set noshowmode

" Settings for ctrlp
" cd ~/.vim/bundle
" git clone https://github.com/kien/ctrlp.vim.git
let g:ctrlp_max_height=30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*
set wildignore+=*/venv/*

" Settings snipmate
" cd ~/.vim/bundle
" git clone https://github.com/msanders/snipmate.vim.git

" Settings surround.vim
" cd ~/.vim/bundle
" git clone https://github.com/tpope/vim-surround.git

" Settings for NERDCommenter
" cd ~/.vim/bundle
" git clone https://github.com/scrooloose/nerdcommenter.git

" ============================================================================
" Python IDE Setup
" ============================================================================
" Run current file
map <Leader>p :w<CR>:!clear && python %<CR>

" Settings python-mode
" cd ~/.vim/bundle
" git clone https://github.com/klen/python-mode.git
noremap <Leader>l :PymodeLintAuto<CR>
noremap <Leader>L :PymodeLint<CR>


" ============================================================================
" C/C++ IDE Setup
" ============================================================================
" Map :make and run current file to a key
map <Leader>r :w<CR>:copen<CR>:make<CR><CR>
