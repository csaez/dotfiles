set nocompatible
filetype off

" Automatic reload of .vimrc
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

" Map execute current file to a key (python)
" TODO: figure out how to use this for different filetypes
map <Leader>p :!python %<CR>

" Grep recursively in the project for the word under the cursor
" and show the results in a quickfix.
map <Leader>g :vimgrep /<C-R><C-W>/j **<CR>:copen<CR>

" Better indentation
vnoremap < <gv
vnoremap > >gv

" show whitespaces
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" ColorScheme
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -0 wombat256mod.vim http://www.vim.org/scripts/download_script
set t_Co=256
color wombat256mod

" Set font to use in gvim
" Please make sure to have Inconsolata installed on your system, it's free!
" http://www.levien.com/type/myfonts/inconsolata.html
set guifont=Inconsolata\ 13

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

" Setup Pathogen to manage your plugins
" mkdir -p ~/.vim/autoload ~/.vim/bundle
" curl -so ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
" Now you can install any plugin into a .vim/bundle/plugin-name/ folder
call pathogen#infect()
call pathogen#helptags()

" ============================================================================
" Python IDE Setup
" ============================================================================
" Settings for vim-powerline
" cd ~/.vim/bundle
" git clone git://github.com/Lokaltog/vim-powerline.git
set laststatus=2

" Settings for ctrlp
" cd ~/.vim/bundle
" git clone https://github.com/kien/ctrlp.vim.git
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*
set wildignore+=*/venv/*

" Settings python-mode
" cd ~/.vim/bundle
" git clone git://github.com/klen/python-mode.git
let g:pymode_lint_on_write = 0
let g:pymode_lint_on_fly = 1
let g:pymode_rope = 1
let g:pymode_rope_goto_definition_cmd = 'vnew'
noremap <Leader>L :PymodeLintAuto<CR>
noremap <Leader>l :PymodeLint<CR>
