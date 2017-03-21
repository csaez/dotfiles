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

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhartington/oceanic-next'

Plug 'mhinz/vim-grepper'
Plug 'neomake/neomake'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-clang'
Plug 'Shougo/neoinclude.vim'
Plug 'zchee/deoplete-jedi', { 'for': 'python' }

Plug 'vim-scripts/Tail-Bundle'
Plug 'https://bitbucket.org/goeb/vimya.git', { 'for': 'python' }

Plug 'avlasyuk/python-syntax', { 'for': 'python' }
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
Plug 'heavenshell/vim-pydocstring', { 'for': 'python' }

call plug#end()

"Configure neomake
"let g:neomake_autolint_sign_column_always = 1
let g:neomake_python_enabled_makers = ['flake8']
autocmd! bufwritepost * Neomake

"Configure deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

" javascript autocomplete
let g:tern_map_keys = 1
let g:tern_show_argument_hints = 'on_hold'
let g:tern_show_signature_in_pum = 1

" c autocomplete
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'
"
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


"on save
autocmd! bufwritepre * :%s/\s\+$//e
autocmd! bufwritepost init.vim source %

"remap leader
let mapleader=' '
let maplocalleader=' '

"clear highlight
noremap <Leader><Space> :nohl<CR>
vnoremap <Leader><Space> :nohl<CR>

"set color scheme
if (has("termguicolors"))
 set termguicolors
endif

" Theme
syntax enable
set background=dark
colorscheme OceanicNext
"let g:codedark_term256=1
"colorscheme codedark

"airline settings
let g:airline_powerline_fonts=1
let g:airline_theme='oceanicnext'
set laststatus=2
set noshowmode

"number line
set number
set relativenumber
set nowrap
set cursorline
set textwidth=99
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

" Map ctrl c as esc
inoremap <C-c> <Esc><Esc>

"python settings
let g:python_highlight_all=1

" Run current python file
map <Leader>p :w<CR>:split \| terminal python %<CR>
map <Leader>mp :w<CR>:split \| terminal /usr/autodesk/maya/bin/mayapy %<CR>

" Grep word under the cursor
nnoremap <leader>* :Grepper -cword -noprompt<CR>
let g:grepper = {}
let g:grepper.highlight = 1
let g:grepper.open = 0

" Paste output external command into scratch buffer
:command! -nargs=* -complete=shellcmd R vnew | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>

" format json
map <Leader>j :R python -m json.tool #<CR>

" neovim virtual environments
let g:python_host_prog = '/home/csaez/.nvim/py2/bin/python'
let g:python3_host_prog = '/home/csaez/.nvim/py3/bin/python'

" terminal settings
:au BufEnter * if &buftype == 'terminal' | :startinsert | endif
highlight TermCursor ctermfg=red guifg=red
tnoremap <Leader><ESC> <C-\><C-n>
