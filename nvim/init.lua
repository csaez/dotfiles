-- -------------------------------------------
-- PLUGINS
-- -------------------------------------------

local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

-- theme
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
Plug 'shaunsingh/nord.nvim'
Plug 'hoob3rt/lualine.nvim'

-- misc
Plug 'nvim-lua/plenary.nvim'
Plug 'mhinz/vim-startify'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'

-- git
Plug 'lewis6991/gitsigns.nvim'

-- fuzzy finder
--Plug 'nvim-telescope/telescope.nvim'
Plug('junegunn/fzf', {['dir'] = '~/.fzf', ['do'] = vim.fn['fzf#install']})
Plug 'junegunn/fzf.vim'

-- lsp
Plug 'neovim/nvim-lspconfig'
Plug 'ojroques/nvim-lspfuzzy'
Plug('jackguo380/vim-lsp-cxx-highlight', {['for'] = 'cpp'})
Plug('filipdutescu/renamer.nvim', { ['branch'] = 'master' })

-- completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'onsails/lspkind-nvim'

-- snippets
Plug 'rafamadriz/friendly-snippets'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

vim.call('plug#end')


-- -------------------------------------------
-- NVIM OPTIONS
-- -------------------------------------------

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


vim.opt.foldmethod = "syntax"
vim.opt.foldenable = false

-- avoid typos
vim.api.nvim_add_user_command("W", "w", {})
vim.api.nvim_add_user_command("Wq", "wq", {})
vim.api.nvim_add_user_command("Q", "q", {})

-- autocommands
vim.api.nvim_create_autocmd("TextYankPost", { callback = function() vim.highlight.on_yank{} end })
vim.api.nvim_create_autocmd("TermOpen", { callback = function() vim.cmd [[ startinsert ]] end })

-- only show cursorline in the active buffer
vim.cmd [[
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END
]]

vim.opt.termguicolors = true

-- -------------------------------------------
-- PLUGINS OPTIONS
-- -------------------------------------------

-- setup color scheme
vim.g.nord_contrast = false
vim.g.nord_borders = true
vim.g.nord_disable_background = false
vim.g.nord_italic = true
require('nord').set()

-- TODO: change these by nvim.api.nvim_set_hl (nvim >= 0.7)
vim.cmd 'hi LspCxxHlGroupEnumConstant ctermfg=Magenta guifg=#B48EAD cterm=none gui=none'
vim.cmd 'hi LspCxxHlGroupNamespace ctermfg=Yellow guifg=#EBCB8E cterm=none gui=none'
vim.cmd 'hi LspCxxHlGroupMemberVariable ctermfg=Blue guifg=#8FBCBB cterm=none gui=none'

vim.cmd 'hi TermCursor ctermfg=Red guifg=#BF616A'
vim.cmd 'hi debugPC term=reverse ctermbg=DarkBlue guibg=#4C566A'
vim.cmd 'hi debugBreakpoint term=reverse ctermbg=Red guibg=#BF616A'
vim.cmd [[:packadd termdebug]]
vim.g.termdebug_wide = 1

-- setup other plugins
require('lualine').setup {
  options = { theme = 'nord' },
  extensions = { 'fzf', 'nvim-tree', 'quickfix' }
}
vim.opt.laststatus = 3  -- global status line (nvim nightly)

require('nvim-tree').setup()

require('colorizer').setup()

require('gitsigns').setup{
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
    map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})
    map({'n', 'v'}, '<leader>hs', gs.stage_hunk)
    map({'n', 'v'}, '<leader>hr', gs.reset_hunk)
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

-- -------------------------------------------
-- LSP OPTIONS
-- -------------------------------------------

-- override floating window borders globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- setup snippets
local luasnip = require("luasnip") -- snippets
local types = require("luasnip.util.types")
require("luasnip.loaders.from_vscode").load()

luasnip.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "", "Error"} },
      },
    },
  },
}

-- setup autocomplete
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local lspkind = require('lspkind')
local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-j>'] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable(1) then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 'c' }),
    ['<C-k>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 'c' }),
    ['<C-l>'] = cmp.mapping(function(fallback)
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      else
        fallback()
      end
    end, { 'i', 'c' }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'luasnip' },
    { name = 'path' },
  }, {
    { name = 'buffer' },
  }),
  formatting = {
    format = lspkind.cmp_format{
      mode = 'symbol',
      with_text = false,
      maxwidth = 50,
      menu = {
        nvim_lsp = '[LSP]',
        nvim_lua = '[nvim]',
        luasnip = '[snip]',
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

-- setup diagnostic signs
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = true,
  }
)

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
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<Leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<Leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

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
    highlight = { lsRanges = true; };
    index = { threads = 0; };
    completion = { detailedLabel = false; };
    compilationDatabaseDirectory = "build";
  }
}

-- use FZF as picker for anything LSP related
require('lspfuzzy').setup {}

-- nicer LSP renamer floating dialog
require("renamer").setup {}

-- -------------------------------------------
-- MAPPINGS
-- -------------------------------------------

local noremap = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<Leader>rn', '<cmd>lua require("renamer").rename()<cr>', noremap)
vim.api.nvim_set_keymap('v', '<Leader>rn', '<cmd>lua require("renamer").rename()<cr>', noremap)

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

vim.api.nvim_set_keymap('n', 'm<Enter>', ':make<CR>', noremap)
vim.api.nvim_set_keymap('n', 'm<Space>', ':make<Space>', {noremap=true})

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

-- toggle tree
vim.api.nvim_set_keymap('n', '<Leader>t', ':NvimTreeFindFileToggle<CR>', noremap)

-- debugger
-- fx and xx are user defined scripts in $PATH finding/running executables in the current dir (recursively)
vim.api.nvim_set_keymap('n', '<Leader>xx', [[ :tabe | term xx<CR> ]], noremap)
vim.api.nvim_set_keymap('n', '<Leader>dd', [[ :call fzf#run(fzf#wrap({'source': 'fx', 'sink': 'Termdebug'}))<CR>]], noremap)
vim.api.nvim_set_keymap('n', '<Leader>dq', ':Gdb<CR>:startinsert<CR>quit<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader>db', ':Break<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader>dc', ':Clear<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader>dk', ':Evaluate<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader><Up>', ':call TermDebugSendCommand("run")<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader><Right>', ':call TermDebugSendCommand("next")<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader><Left>', ':call TermDebugSendCommand("continue")<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader><Down>', ':call TermDebugSendCommand("step")<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader><PageUp>', ':call TermDebugSendCommand("up")<CR>', noremap)
vim.api.nvim_set_keymap('n', '<Leader><PageDown>', ':call TermDebugSendCommand("down")<CR>', noremap)
