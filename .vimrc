" My vim config!
" I have very little idea of what I'm doing here.

" These I grabbed from http://michael.peopleofhonoronly.com/vim/vim_cheat_sheet_for_programmers_screen.pdf 
set nocompatible
set ruler
set laststatus=2
set showcmd
set showmode
set number relativenumber
set incsearch
set ignorecase
set smartcase
set hlsearch
set shortmess+=Ic
set splitbelow splitright
set wildmode=longest,list

" Fixing tabs in vim
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab

set cmdheight=2
set nobackup
set nowritebackup
set hidden
set updatetime=300
set signcolumn=yes

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" UI
Plug 'arcticicestudio/nord-vim'

" General functionality
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf.vim'

" Language-related
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fireplace'
Plug 'bhurlow/vim-parinfer'

" Additional functionality
Plug 'vimwiki/vimwiki'

call plug#end()

colorscheme nord

" Below are many configs for coc-nvim.
" I don't really know yet how it all works. Yes, I should. :)

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

let mapleader=" "

nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>. :Files<CR>
nnoremap <leader><space> :GFiles<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>h :History<CR>
nnoremap <leader>f :Rg<CR>

let g:ale_fixers = { 'javascript': ['eslint'], 'rust': ['rustfmt'] }
let g:ale_fix_on_save = 1
