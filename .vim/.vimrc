set nocompatible
filetype off
" call pathogen#runtime_append_all_bundles()
filetype plugin indent on
set title
set number
set relativenumber
syntax on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set modelines=0
set autowrite
set t_Co=256
colorscheme onehalfdark

execute pathogen#infect()

" Different tabs for different filetypes
autocmd Filetype javascript setlocal ts=2 sw=2 sts=2
autocmd Filetype typescript setlocal ts=2 sw=2 sts=2
autocmd Filetype gohtmltmpl setlocal ts=2 sw=2 sts=2
autocmd Filetype css setlocal ts=2 sw=2 sts=2
autocmd Filetype pug setlocal ts=2 sw=2 sts=2
autocmd Filetype python setlocal ts=2 sw=2 sts=2
autocmd Filetype vue setlocal ts=2 sw=2 sts=2

" escape shortcuts
inoremap jk <ESC>
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" leader commads start with SPACEBAR
let mapleader = ","

" Language things
set encoding=utf-8
set spell spelllang=en_us
set spell!

" Ensure proper clipboard, and avoid breaking commands
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed "OSX
else
  set clipboard=unnamedplus "Linux
endif

" Toggle Line Comment
let NERDSpaceDelims=1
nnoremap ,c :call NERDComment(0,"toggle")<CR>
vnoremap ,c :call NERDComment(0,"toggle")<CR>

" Leader commands
" Spellcheck on/off
nnoremap <leader>s :set spell!
" Clean out whitespace at end of line
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" Split window vertically
nnoremap <leader>w <C-w>v<C-w>l
" Window Navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Open File Tree
map <leader>t :NERDTreeToggle<cr>
" Go on and build!
map <leader>b :GoBuild<cr>
" Test function under cursor
map <leader>T :GoTestFunc<cr>
" Go on and lint it for me
map <leader>l :GoLint<cr>
" Clear search highlighting
map <leader>/ :noh<cr>

set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
"set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set undofile
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %
nnoremap ; :
set nowrap
"set textwidth=79
"set formatoptions=qrn1
"set colorcolumn=85
nmap <silent> ,/ :nohlsearch<CR>

" NO ARROW KEYS ALLOWED
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

"Line wrapping
"set wrap
"nnoremap j gj
"nnoremap k gk

"CtrlP Stuff
nnoremap <leader>p <Plug>YankRing
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Autosave on lose focus
au FocusLost * :wa

" No noise or flash for errors!
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Dark/Light scheme toggle stuff
let g:colorscheme = "dark"

function! ToggleDark()
  if g:colorscheme == "dark"
      colorscheme onehalflight
      let g:colorscheme= "light"
  else
      colorscheme onehalfdark
      let g:colorscheme= "dark"
  endif
endfunction

nnoremap <leader>m :call ToggleDark()<CR>

" Run go lint in save for go files
:autocmd BufWritePost *.go :GoLint
:autocmd BufWritePost *.go :GoVet
":autocmd BufWritePost *.go :GoErrCheck

" Syntax highlighting
au BufRead,BufNewFile *.gohtml set filetype=gohtmltmpl

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col
        return "\<tab>"
    endif

    let char = getline('.')[col - 1]
    if char =~ '\k'
        " There's an identifier before the cursor, so complete the identifier.
        return "\<c-p>"
    else
        return "\<tab>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>
