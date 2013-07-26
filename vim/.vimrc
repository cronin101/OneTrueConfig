" Load ~/.vim/bundle packages.
call pathogen#infect()
call pathogen#helptags()

" Use Vim defaults
set nocompatible

" Colorscheme settings.
syntax enable
set t_Co=256
set background=dark
colorscheme solarized
let g:airline_theme='solarized'

" UTF8 or die.
set encoding=utf8

" :BundleInstall packages.
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'Valloric/YouCompleteMe'

" Numbered lines.
set number

" Keep cursor away from edges of screen.
set so=14

" Highlight cursor line.
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
  au WinLeave * setlocal nocursorline
  au WinLeave * setlocal nocursorcolumn
augroup END

" Mouse usage enabled in normal mode.
set mouse=n

" Control character highlighting.
set list listchars=tab:⇥⇥,eol:↵
set ignorecase smartcase

" Tab settings.
set expandtab
set shiftwidth=2
set ts=2
set smarttab
set cindent
let indent_guides_enable_on_vim_startup = 1

" Parens matching.
set showmatch
set matchtime=5

" EasyMotion word jumping.
let g:EasyMotion_leader_key = "'"

" Always show current position.
set ruler

" No screen redrawing during macros.
set lazyredraw

" Command bar prettification.
set cmdheight=1
set showmode
set showcmd
set shortmess=atI

" Search settings.
set magic
set incsearch
set hlsearch
set ignorecase
set smartcase

" No extra files.
set noswapfile
set nobackup
set nowritebackup

" WiLd menu.
set wildmenu
set wildignore=*.o,*~,*.pyc

" Aesthetics.
set title
set laststatus=2

" No annoying alerts.
set noerrorbells
set novisualbell

" Turn off auto-indentation when pasting with F5.
nnoremap <F5> :set invpaste paste?<Enter>
imap <F5> <C-O><F5>
set pastetoggle=<F5>

" Filetype detection and indentation.
filetype plugin indent on
" OpenCL syntax highlighing enabled.
au BufNewFile,BufRead *.cl set filetype=opencl

" Use <F11> and <F12> to copy and paste selected line to primary clipboard.
map <F11> :!xclip -f<CR>
map <F12> :r !xclip -o<CR>

" Re-map leader key to \.
let mapleader = "\\"
map <Leader>x :x<CR>
map <Leader>q :q<CR>
map <Leader>w :w<CR>

" NERDTree settings.
let NERDTreeMinimalUI=1
map <Leader>n :NERDTreeToggle<CR>

" Make trailing whitespace annoyingly highlighted.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Tagbar for displaying in-file definitions.
let g:tagbar_usearrows = 1
nnoremap <leader>l :TagbarToggle<CR>

" F9 for folding stuff.
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

" ^J for snippet completion.
let g:BASH_Ctrl_j = 'off'
imap <C-J> <esc>a<Plug>snipMateNextOrTrigger
smap <C-J> <Plug>snipMateNextOrTrigger

" Use tmux for Slime.
let g:slime_target = "tmux"

" Change cursor shape in different modes on tmux iTerm2
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

" Remove the small delay between pressing Esc and entering Normal mode.
if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

" HARD MODE SETTINGS
  " Minimal GUI.
  set guioptions=c

  " Disable arrow keys.
  map <up> <nop>
  map <down> <nop>
  map <left> <nop>
  map <right> <nop>
  imap <up> <nop>
  imap <down> <nop>
  imap <left> <nop>
  imap <right> <nop>

  " Automatically leave insert mode after 'updatetime' (4s by default).
  au CursorHoldI * stopinsert

  " Disable h,j,k,l keys by default.
  "autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

  " Toggle hardmode
  nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>

