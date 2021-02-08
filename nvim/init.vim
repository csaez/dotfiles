call plug#begin('~/.config/nvim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'jackguo380/vim-lsp-cxx-highlight'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'machakann/vim-highlightedyank'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'


Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'arcticicestudio/nord-vim'

Plug 'scrooloose/nerdcommenter'

call plug#end()

let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

autocmd! bufwritepost init.vim source %  " source init.vim on save

if (has("termguicolors"))
 set termguicolors
  set t_ut=  " disable Background Color Erase (BCE)
endif

" theme
syntax enable
let g:nord_cursor_line_number_background = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1
colorscheme nord

let g:airline_powerline_fonts = 1
let g:airline_theme='nord'

set laststatus=2
set noshowmode
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

" don't use TABs but spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set autoindent
set expandtab

" show tab characters
set list
set listchars=tab:→\ ,eol:↲

" Map ctrl c as esc
inoremap <C-c> <Esc><Esc>

" remap leader
let mapleader=' '
let maplocalleader=' '

" clear highlight
noremap <Leader><Space> :nohl<CR>
vnoremap <Leader><Space> :nohl<CR>

" terminal settings
:au BufEnter * if &buftype == 'terminal' | :startinsert | endif  " go to insert mode on focus
highlight TermCursor ctermfg=red guifg=red
tnoremap <Leader><ESC> <C-\><C-n>

" avoid typos
:command! W :w
:command! Wq :wq
:command! Q :q

" FZF mappings
nnoremap <C-P> :Files<CR>
nnoremap <Leader>* :Ag <C-R><C-W><CR>

" autocomplete
let g:completion_chain_complete_list = [
    \{'complete_items': ['lsp', 'path']},
    \{'mode': '<c-p>'},
    \{'mode': '<c-n>'}
\]"
let g:completion_auto_change_source = 1
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

autocmd BufEnter * lua require'completion'.on_attach()
set completeopt=menuone,noinsert,noselect
set shortmess+=c
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" configure diagnostics
nnoremap <leader>q <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <leader>w <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

lua << EOF
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = true,
  }
)
EOF

"LSP
set signcolumn=yes
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K  <cmd>lua vim.lsp.buf.hover()<CR>

lua <<EOF
local lspconfig = require'lspconfig'
lspconfig.cmake.setup {}
lspconfig.pyls.setup {}
lspconfig.rls.setup {}
lspconfig.ccls.setup {
  init_options = {
    compilationDatabaseDirectory = "build",
    highlight = {lsRanges = true}
  };
}
EOF

" use cargo with rust
autocmd Filetype rust setlocal makeprg=cargo

" Redirect the output of a Vim or external command into a scratch buffer 
function! Redir(cmd, rng, start, end)
  for win in range(1, winnr('$'))
    if getwinvar(win, 'scratch')
      execute win . 'windo close'
    endif
  endfor
  if a:cmd =~ '^!'
    let cmd = a:cmd =~' %'
      \ ? matchstr(substitute(a:cmd, ' %', ' ' . expand('%:p'), ''), '^!\zs.*')
      \ : matchstr(a:cmd, '^!\zs.*')
    if a:rng == 0
      let output = systemlist(cmd)
    else
      let joined_lines = join(getline(a:start, a:end), '\n')
      let cleaned_lines = substitute(shellescape(joined_lines), "'\\\\''", "\\\\'", 'g')
      let output = systemlist(cmd . " <<< $" . cleaned_lines)
    endif
  else
    redir => output
    execute a:cmd
    redir END
    let output = split(output, "\n")
  endif
  vnew
  let w:scratch = 1
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
  call setline(1, output)
endfunction

command! -nargs=1 -complete=command -bar -range R silent call Redir(<q-args>, <range>, <line1>, <line2>)
