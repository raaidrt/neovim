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
