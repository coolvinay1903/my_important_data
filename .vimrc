set history=1000
set autoread
set nu
set ruler
set magic
set showmatch
set expandtab
set shiftwidth=4
set tabstop=4
set ai
set si
set noswapfile
set ic
syntax on
filetype plugin indent on
au BufNewFile,BufRead,BufEnter *.cpp,*.hpp,*.C,*.h,*.c set omnifunc=syntaxcomplete#Complete
"set mouse=a
set virtualedit=onemore
"set spell
"set cursorline
set showcmd
set wildmenu
"set foldenable
set incsearch
set hlsearch
set ignorecase
set smartcase
set pastetoggle=<F3>
set clipboard=unnamed
set nostartofline
"set title
set ttyfast
set shortmess=atI
set t_Co=128
:color desert
if has("gui_running")
  set guioptions-=T
  set guioptions+=e
  set t_Co=256
  set guitablabel=%M\ %t
  highlight Normal guibg=Gray90
  "set selectmode=mouse,key,cmd
endif

vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

"source $VIMRUNTIME/mswin.vim
"normal copy/paste
vmap <C-c> y<Esc>i
vmap <C-x> d<Esc>i
imap <C-v> <Esc>pi
imap <C-y> <Esc>ddi
"map <C-z> <Esc>
imap <C-z> <Esc>ui
imap <C-s> <ESC>:w<CR>i
"imap <C-a> <ESC>:wq<CR>
imap <C-BS> <C-W>
map <Bs> BACK
"highlight Pmenu guibg=black gui=bold guifg=white
"highlight Pmenu ctermbg=black gui=bold
highlight Pmenu ctermbg=13 guibg=Gray70
highlight PmenuSel ctermbg=7 guibg=DarkBlue guifg=White
highlight PmenuSbar ctermbg=7 guibg=DarkGray
highlight PmenuThumb guibg=Black
