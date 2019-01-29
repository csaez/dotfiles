call plug#begin('~/.nvim/plugged')

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'machakann/vim-highlightedyank'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'scrooloose/nerdcommenter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhartington/oceanic-next'

Plug 'mhinz/vim-grepper'

Plug 'avlasyuk/python-syntax', { 'for': 'python' }
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
Plug 'vim-scripts/Tail-Bundle'
Plug 'https://bitbucket.org/goeb/vimya.git', { 'for': 'python' }

Plug 'peterhoeg/vim-qml', { 'for': 'qml' }
Plug 'tikhomirov/vim-glsl', { 'for': 'glsl' }

Plug 'mattn/emmet-vim', { 'for': ['html', 'css'] }

" Language server client
Plug 'roxma/nvim-yarp'  " required by ncm2
Plug 'ncm2/ncm2'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

call plug#end()

" configure ultisnipts
let g:UltiSnipsExpandTrigger="<c-j>"

" ctrlp settings
let g:ctrlp_max_height=30
set wildignore+=*.pyc
set wildignore+=*egg-info/*
set wildignore+=*/build/*
set wildignore+=*_build/*
set wildignore+=*/coverage/*
set wildignore+=*/venv/*
set wildignore+=*target/*  " rust

" set color scheme
if (has("termguicolors"))
 set termguicolors
  " disable Background Color Erase (BCE)
  set t_ut=
endif

" theme
syntax enable
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
colorscheme OceanicNext

" airline settings
let g:airline_powerline_fonts=1
let g:airline_theme='oceanicnext'
set laststatus=2
set noshowmode

" on save
autocmd! bufwritepre * :%s/\s\+$//e      " remove white space
autocmd! bufwritepost init.vim source %  " source init.vim

"number line
set number
set relativenumber
set nowrap
set cursorline
set textwidth=99
set colorcolumn=+1  " highlight column after 'textwidth'
set mouse=a

"better search
set hlsearch
set incsearch
set ignorecase
set smartcase

"disable backup and swap files
set nobackup
set nowritebackup
set noswapfile

" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set autoindent
set expandtab

" Map ctrl c as esc
inoremap <C-c> <Esc><Esc>

" remap leader
let mapleader=' '
let maplocalleader=' '

" avoid typos
:command! W :w
:command! Wq :wq
:command! Q :q

" configure grepper (async grep)
nnoremap <Leader>* :Grepper -tool git -cword -noprompt -noopen -highlight<CR>

" clear highlight
noremap <Leader><Space> :nohl<CR>
vnoremap <Leader><Space> :nohl<CR>

" Paste output external command into scratch buffer
:command! -nargs=* -complete=shellcmd R vnew | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>
map <Leader>j :R python -m json.tool #<CR>

" terminal settings
:au BufEnter * if &buftype == 'terminal' | :startinsert | endif  " go to insert mode on focus
highlight TermCursor ctermfg=red guifg=red
tnoremap <Leader><ESC> <C-\><C-n>

" configure python
let g:python_host_prog = '/home/csaez/.nvim/py2/bin/python'
let g:python3_host_prog = '/home/csaez/.nvim/py3/bin/python'

let g:python_highlight_all=1

map <Leader>py :w<CR>:split \| terminal python %<CR>i<CR>
map <Leader>pyd :w<CR>:split \| terminal python -m pdb %<CR>
map <Leader>mpy :w<CR>:split \| terminal /usr/autodesk/maya/bin/mayapy %<CR>

map <Leader>rr :w<CR>:split \| terminal cargo run<CR>
map <Leader>rb :w<CR>:split \| terminal cargo build<CR>
map <Leader>rt :w<CR>:split \| terminal cargo test<CR>

" dasht (documentation)
nnoremap <Leader>h :tabe \| terminal dasht <Space>
nnoremap <Leader>hh :tabe \| terminal dasht <C-R><C-W><CR>

" configure lsp
set hidden  " Required for operations modifying multiple buffers like rename.
set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'python': ['~/.nvim/py2/bin/pyls'],
    \ }

nnoremap <Leader>gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <Leader>ide :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
