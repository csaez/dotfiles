-- Plugins
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

-- theme
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
Plug 'arcticicestudio/nord-vim'
Plug 'folke/todo-comments.nvim'
Plug 'hoob3rt/lualine.nvim'

-- misc
Plug 'kyazdani42/nvim-tree.lua'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'

-- git
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'

-- fuzzy finder
Plug('junegunn/fzf', {['dir'] = '~/.fzf', ['do'] = vim.fn['fzf#install']})
Plug 'junegunn/fzf.vim'

-- lsp
Plug 'neovim/nvim-lspconfig'
Plug 'ojroques/nvim-lspfuzzy'
Plug('jackguo380/vim-lsp-cxx-highlight', {['for'] = 'cpp'})

-- completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'onsails/lspkind-nvim'
Plug 'hrsh7th/cmp-nvim-lua'

vim.call('plug#end')

-- find python
vim.g.python_host_prog = '/usr/bin/python2'
vim.g.python3_host_prog = '/usr/bin/python3'

-- setup leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- misc options
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.textwidth = 99
vim.opt.colorcolumn = '+1'
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.autoindent = true
vim.opt.expandtab = true

vim.opt.list = true
vim.opt.listchars = [[tab:→\ ,eol:↲]]

-- avoid typos
vim.cmd [[command! W :w]]
vim.cmd [[command! Wq :wq]]
vim.cmd [[command! Q :q]]

-- autocommands
vim.cmd [[autocmd TextYankPost * lua vim.highlight.on_yank {}]]
vim.cmd [[autocmd TermOpen * startinsert]]

-- keyboard mapings
local noremap = { noremap=true, silent=true }
vim.api.nvim_set_keymap('i', '<C-c>', '<Esc><Esc>', noremap)
vim.api.nvim_set_keymap('', '<Leader><Space>', ':nohl<CR>', noremap)
vim.api.nvim_set_keymap('v', '<Leader><Space>', ':nohl<CR>', noremap)
vim.api.nvim_set_keymap('t', '<Leader><Esc>', [[<C-\><C-n>]], noremap)

vim.api.nvim_set_keymap('', '<Leader>y', '"+y', noremap)
vim.api.nvim_set_keymap('', '<Leader>Y', '"+yy', noremap)
vim.api.nvim_set_keymap('', '<Leader>p', '"+p', noremap)
vim.api.nvim_set_keymap('', '<Leader>P', '"+P', noremap)

vim.api.nvim_set_keymap('n', '<C-p>', ':Files<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader>*', ':Ag <C-R><C-w><CR>', noremap)

-- use fzf for spell check
vim.api.nvim_exec([[
  function! FzfSpellSink(word)
    exe 'normal! "_ciw'.a:word
  endfunction
  function! FzfSpell()
    let suggestions = spellsuggest(expand("<cword>"))
    return fzf#run(fzf#wrap({'source': suggestions, 'sink': function("FzfSpellSink"), 'down': 10}))
  endfunction
  nnoremap z= :call FzfSpell()<CR>
  ]], false)

-- color scheme (order is important)
vim.opt.termguicolors = true
vim.g.nord_cursor_line_number_background = 1
vim.g.nord_italic = 1
vim.g.nord_italic_comments = 1
vim.cmd 'colorscheme nord'
vim.cmd 'hi LspCxxHlGroupEnumConstant ctermfg=Magenta guifg=#B48EAD cterm=none gui=none'
vim.cmd 'hi LspCxxHlGroupNamespace ctermfg=Yellow guifg=#EBCB8E cterm=none gui=none'
vim.cmd 'hi LspCxxHlGroupMemberVariable ctermfg=Blue guifg=#8FBCBB cterm=none gui=none'
vim.cmd 'hi TermCursor ctermfg=red guifg=#BF616A'

-- todo comments
require("todo-comments").setup{
  search = {
    command = "ag",
    args = {
      "--nocolor",
      "--noheading",
      "--filename",
      "--number",
      "--column",
    },
  }
}

-- git signs
require('gitsigns').setup()

-- lualine setup
require'lualine'.setup {
  options = { theme = 'nord' },
  extensions = { 'fzf', 'nvim-tree', 'quickfix' }
}

-- nvim-tree setup
require'nvim-tree'.setup()
vim.api.nvim_set_keymap('n', '<Leader>t', ':NvimTreeFindFileToggle<CR>', noremap)

-- LSP setup, requires patched nerd font (otherwise ● is a good candidate)
vim.cmd [[sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl= ]]
vim.cmd [[sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl= ]]
vim.cmd [[sign define LspDiagnosticsSignInformation text=🛈 texthl=LspDiagnosticsSignInformation linehl= numhl= ]]
vim.cmd [[sign define LspDiagnosticsSignHint text=❗ texthl=LspDiagnosticsSignHint linehl= numhl= ]]

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = true,
  }
)

-- debugger
vim.api.nvim_exec([[
  hi debugPC term=reverse ctermbg=darkblue guibg=#4C566A
  hi debugBreakpoint term=reverse ctermbg=red guibg=#BF616A
]], false)

vim.cmd [[:packadd termdebug]]
vim.g.termdebug_wide = 1
vim.api.nvim_set_keymap('n', '<F4>', ':Run<CR>', noremap)
vim.api.nvim_set_keymap('n', '<F5>', ':Continue<CR>', noremap)
vim.api.nvim_set_keymap('n', '<F6>', ':Stop<CR>', noremap)
vim.api.nvim_set_keymap('n', '<F7>', ':Evaluate<CR>', noremap)
vim.api.nvim_set_keymap('n', '<F8>', ':Break<CR>', noremap)
vim.api.nvim_set_keymap('n', '<F9>', ':Over<CR>', noremap)
vim.api.nvim_set_keymap('n', '<F10>', ':Step<CR>', noremap)
vim.api.nvim_set_keymap('n', '<F11>', ':Finish<CR>', noremap)

vim.api.nvim_set_keymap('n', '<Leader>dd', [[:call fzf#run(fzf#wrap({'source': 'find ./build -type f -executable -exec file {} \; | grep -wE executable | grep -Po ".*(?=:)"', 'sink': 'Termdebug'}))<CR>]], noremap)

-- setup colorizer
require('colorizer').setup()

-- setup autocomplete
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local lspkind = require('lspkind')
local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'ultisnips' },
    { name = 'path' },
  }, {
    { name = 'buffer' },
  }),
  formatting = {
    format = lspkind.cmp_format{
      with_text = false,
      maxwidth = 50,
      menu = {
        nvim_lsp = '[LSP]',
        nvim_lua = '[nvim]',
        ultisnips = '[snip]',
        path = '[path]',
        buffer = '[buf]',
      },
    },
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
})

-- Setup lsp
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<Leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<Leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<Leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<Leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<Leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end
  if client.resolved_capabilities.code_action then
    buf_set_keymap("n", "<Leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#4C566A
      hi LspReferenceText cterm=bold ctermbg=red guibg=#4C566A
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#4C566A
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "cmake", "pylsp", "rls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach
  }
end
nvim_lsp.ccls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  init_options = {
    highlight = { lsRanges = true };
    index = { threads = 0 };
    completion = { detailedLabel = false };
    compilationDatabaseDirectory = "build";
  }
}
require('lspfuzzy').setup {} -- LSP client use FZF instead of quickfix
