call plug#begin('~/.nvim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'

Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdcommenter'
Plug 'kien/ctrlp.vim'

Plug 'mhartington/oceanic-next'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

Plug 'benekastah/neomake'
Plug 'vhdirk/vim-cmake'

Plug 'vim-scripts/Tail-Bundle'
Plug 'https://bitbucket.org/goeb/vimya.git'

Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

Plug 'avlasyuk/python-syntax', { 'for': 'python' }
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
Plug 'tmhedberg/SimpylFold', { 'for': 'python' }

Plug 'derekwyatt/vim-scala', { 'for': 'scala' }
Plug 'ktvoelker/sbt-vim', { 'for': 'scala' }

call plug#end()

"map YCM goto definition
nnoremap <C-c>g :YcmCompleter GoTo<CR>
nnoremap K :YcmCompleter GetDoc<CR>

"configure ultisnipts
let g:UltiSnipsExpandTrigger="<c-j>"

"hide scratch on help
set completeopt=menu,menuone,longest

"configure supertab
let g:SuperTabDefaultCompletionType="context"
let g:SuperTabContextDefaultCompletionType="<c-x><c-o>"

"ctrlp settings
let g:ctrlp_max_height=30
set wildignore+=*.pyc
set wildignore+=*egg-info/*
set wildignore+=*/build/*
set wildignore+=*_build/*
set wildignore+=*/coverage/*
set wildignore+=*/venv/*

"airline settings
let g:airline_powerline_fonts=1
let g:airline_theme='oceanicnext'
set laststatus=2
set noshowmode

"python settings
let g:python_highlight_all=1

"on save
autocmd! bufwritepre * :%s/\s\+$//e
autocmd! bufwritepost * Neomake
autocmd! bufwritepost init.vim source %

"remap leader
let mapleader=','

"clear highlight
noremap <Leader>, :nohl<CR>
vnoremap <Leader>, :nohl<CR>
inoremap <Leader>, :nohl<CR>

"set color scheme
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark
colorscheme OceanicNext

"number line
set number
set relativenumber
set nowrap
set cursorline
set textwidth=100
set colorcolumn=+1  " highlight column after 'textwidth'

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

" Start editing with all folds open
set foldlevelstart=99

" Map ctrl c as esc
inoremap <C-c> <Esc><Esc>

" Run current python file
map <Leader>p :w<CR>:!python %<CR>

" Grep word under the cursor
map <Leader>g :vimgrep /<C-R><C-W>/ **/*.

" Paste output external command into scratch buffer
:command! -nargs=* -complete=shellcmd R vnew | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>

" format json
map <Leader>j :R python -m json.tool #<CR>
