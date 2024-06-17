set nocompatible 
filetype off 
set paste
set mouse=a

call plug#begin('~/.config/nvim/plugged')
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'MunifTanjim/nui.nvim'
Plug 'ShinKage/idris2-nvim'
call plug#end()

colorscheme gruvbox
map <silent> <C-n> :NERDTreeFocus<CR>

filetype plugin indent on
syntax on
set colorcolumn=80
set background=dark
highlight Colorcolumn ctermbg=0 guibg=lightgrey
set number
set nowrap
set smartcase 
set hlsearch
set noerrorbells
set tabstop=2 softtabstop=2
set expandtab
set smartindent

let maplocalleader = ','

" Idris LSP settings
"
" Press `gd` on a function, constructor, or operator to jump to its definition
" (for external modules, this works only if they were installed with
" idris2 --install-with-src)
"
" Press `K` on a function, constructor, or operator to print its type.
" Works especially well with holes.
"
" Press `<localleader>a` to add a new clause to a definition.
"
" Press `<localleader>c` to add a case split on a variable.
"
" Press `<localleader>o` to start an expression search.
lua << EOF

-- shortcut for displaying error messages in a popup.
vim.cmd [[nnoremap <LocalLeader><LocalLeader>e <Cmd>lua vim.diagnostic.open_float()<CR>]]
-- shortcut for displaying error messages in a separate window.
vim.cmd [[nnoremap <LocalLeader><LocalLeader>el <Cmd>lua vim.diagnostic.setloclist()<CR>]]

-- command to run after every code action.
local function save_hook(action)
  vim.cmd('silent write')
end

local opts = {
  client = {
    hover = {
      use_split = false, -- Persistent split instead of popups for hover
      split_size = '30%', -- Size of persistent split, if used
      auto_resize_split = false, -- Should resize split to use minimum space
      split_position = 'bottom', -- bottom, top, left or right
      with_history = false, -- Show history of hovers instead of only last
    },
  },
  server = {
    on_attach = function(...)
      vim.cmd [[nnoremap gd <Cmd>lua vim.lsp.buf.definition()<CR>]]
      vim.cmd [[nnoremap K <Cmd>lua vim.lsp.buf.hover()<CR>]]

      vim.cmd [[nnoremap <LocalLeader>c <Cmd>lua require('idris2.code_action').case_split()<CR>]]
      vim.cmd [[nnoremap <LocalLeader>mc <Cmd>lua require('idris2.code_action').make_case()<CR>]]
      vim.cmd [[nnoremap <LocalLeader>mw <Cmd>lua require('idris2.code_action').make_with()<CR>]]
      vim.cmd [[nnoremap <LocalLeader>ml <Cmd>lua require('idris2.code_action').make_lemma()<CR>]]
      vim.cmd [[nnoremap <LocalLeader>a <Cmd>lua require('idris2.code_action').add_clause()<CR>]]
      vim.cmd [[nnoremap <LocalLeader>o <Cmd>lua require('idris2.code_action').expr_search()<CR>]]
      vim.cmd [[nnoremap <LocalLeader>gd <Cmd>lua require('idris2.code_action').generate_def()<CR>]]
      vim.cmd [[nnoremap <LocalLeader>rh <Cmd>lua require('idris2.code_action').refine_hole()<CR>]]

      vim.cmd [[nnoremap <LocalLeader>so <Cmd>lua require('idris2.hover').open_split()<CR>]]
      vim.cmd [[nnoremap <LocalLeader>sc <Cmd>lua require('idris2.hover').close_split()<CR>]]

      vim.cmd [[nnoremap <LocalLeader>mm <Cmd>lua require('idris2.metavars').request_all()<CR>]]
      vim.cmd [[nnoremap <LocalLeader>mn <Cmd>lua require('idris2.metavars').goto_next()<CR>]]
      vim.cmd [[nnoremap <LocalLeader>mp <Cmd>lua require('idris2.metavars').goto_prev()<CR>]]

      vim.cmd [[nnoremap <LocalLeader>br <Cmd>lua require('idris2.browse').browse()<CR>]]

      vim.cmd [[nnoremap <LocalLeader>x <Cmd>lua require('idris2.repl').evaluate()<CR>]]
    end,
    init_options = {
      logFile = "~/.cache/idris2-lsp/server.log",
      longActionTimeout = 2000, -- 2 second
    },
  },
  autostart_semantic = true, -- Should start and refresh semantic highlight automatically
  code_action_post_hook = save_hook, -- Function to execute after a code action is performed:
  use_default_semantic_hl_groups = true, -- Set default highlight groups for semantic tokens
}
require('idris2').setup(opts)
EOF
