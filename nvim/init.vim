call plug#begin('~/.nvim/plugged')

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'

Plug 'ervandew/supertab'
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
Plug 'neomake/neomake'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'avlasyuk/python-syntax', { 'for': 'python' }
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
Plug 'heavenshell/vim-pydocstring', { 'for': 'python' }
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'vim-scripts/Tail-Bundle'
Plug 'https://bitbucket.org/goeb/vimya.git', { 'for': 'python' }

Plug 'tikhomirov/vim-glsl', { 'for': 'glsl' }

Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'sebastianmarkow/deoplete-rust', {'for' : 'rust'}

Plug 'zchee/deoplete-clang', { 'for': 'cpp' }
Plug 'Shougo/neoinclude.vim', { 'for': 'cpp' }

call plug#end()

"Configure neomake
let g:neomake_verbose=0
let g:neomake_echo_current_error=1
autocmd! bufwritepost * Neomake

"Configure deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

" configure ultisnipts
let g:UltiSnipsExpandTrigger="<c-j>"

" configure supertab
let g:SuperTabDefaultCompletionType="context"
let g:SuperTabContextDefaultCompletionType="<c-x><c-o>"

" ctrlp settings
let g:ctrlp_max_height=30
set wildignore+=*.pyc
set wildignore+=*egg-info/*
set wildignore+=*/build/*
set wildignore+=*_build/*
set wildignore+=*/coverage/*
set wildignore+=*/venv/*

" set color scheme
if (has("termguicolors"))
 set termguicolors
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

" hide scratch on help
set completeopt=menu,menuone,longest

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
let g:jedi#completions_enabled = 0  " completion done by deoplete
let g:neomake_python_enabled_makers = ['flake8']

map <Leader>p :w<CR>:split \| terminal python %<CR>
map <Leader>mp :w<CR>:split \| terminal /usr/autodesk/maya/bin/mayapy %<CR>


" configure rust.vim
let g:neomake_rust_enabled_makers = ['cargo']
let g:deoplete#sources#rust#racer_binary='/home/csaez/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='/home/csaez/.nvim/rust/src'

map <Leader>r :w<CR>:split \| terminal cargo run<CR>


" configure javascript autocomplete
let g:tern_map_keys = 1
let g:tern_show_argument_hints = 'on_hold'
let g:tern_show_signature_in_pum = 1


" configure clang autocomplete
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'
