set nocompatible

"======================
" Setup Plugins
"======================

" Setup Vundle to manage your plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts=1
set laststatus=2
set noshowmode

" Settings for ctrlp
Plugin 'kien/ctrlp.vim'
let g:ctrlp_max_height=30
set wildignore+=*.pyc
set wildignore+=*egg-info/*
set wildignore+=*/build/*
set wildignore+=*_build/*
set wildignore+=*/coverage/*
set wildignore+=*/venv/*

" tpope is the man!
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'

" Settings for NERDCommenter
Plugin 'scrooloose/nerdcommenter'

Plugin 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

" Autocompletion, it's sper fast but need to be compiled
Plugin 'Valloric/YouCompleteMe'
nnoremap <c-c>g :YcmCompleter GoTo<CR>

" snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

let g:UltiSnipsExpandTrigger="<c-j>"

" Linter, needs pylint or flakes8 installed systemwise (but it's great!)
Plugin 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_ballons = 0

let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_error_symbol = '≈'
let g:syntastic_style_warning_symbol = '≈'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn


" Enhaced python syntax highlighting
Plugin 'avlasyuk/python-syntax'
let g:python_highlight_all = 1

" Enhaced python indentation
Plugin 'hynek/vim-python-pep8-indent'

" Color themes
Plugin 'tomasr/molokai'
Plugin 'morhetz/gruvbox'

" run maya commands from vim
Plugin 'vim-scripts/Tail-Bundle'
Plugin 'http://bitbucket.org/goeb/vimya'

call vundle#end()
filetype plugin indent on


"======================
" Settings
"======================

" Set language
set langmenu=en_US
let $LANG="en_US"
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Set font to use in gvim
set guifont=Hack\ 12

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
"set pastetoggle=<F2>
"set clipboard=unnamed

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

" show whitespaces
"autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
"au InsertLeave * match ExtraWhitespace /\s\+$/

" Remove trailing spaces on save (*.py files only)
autocmd BufWritePre *.py :%s/\s\+$//e

" ColorScheme
set t_Co=256
set background=dark

color molokai
let airline_theme='hybridline'
let g:rehash256 = 1
let g:molokai_original = 1

"color gruvbox
"let airline_theme='gruvbox'
"let g:gruvbox_contrast_dark='hard'

" Syntax highlight
filetype off
syntax on

" Showing line numbers and length
set relativenumber
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

" Complete options (disable preview scratch window)
set completeopt=menu,menuone,longest

" Run current python file
map <Leader>p :w<CR>:!clear && python %<CR>

" Map :make and run current file to a key
map <Leader>R :w<CR>:copen<CR>:make<CR><CR>
