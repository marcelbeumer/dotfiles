" //////////////////////////////
" # vim settings
" //////////////////////////////

" get vimrc flavour
let flavour=$VIMRC_FLAVOUR
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" My bundles
Bundle 'ack.vim'
Bundle 'django.vim'
Bundle 'Tagbar'
Bundle 'tComment'
Bundle 'vcscommand.vim'

Bundle 'pangloss/vim-javascript'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'ervandew/supertab'
Bundle 'wincent/Command-T'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'msanders/snipmate.vim'
Bundle 'tpope/vim-surround'
Bundle 'chrismetcalf/vim-yankring'
Bundle 'bitc/vim-bad-whitespace'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'sjl/gundo.vim'
Bundle 'mrtazz/molokai.vim'
Bundle 'marcelbeumer/twilight.vim'

syntax enable
filetype plugin indent on

set macmeta " Set left and right option/alt keys to be meta keys
" be able to switch buffers without saving
set hidden
" no backups or swaps needed
set nobackup
set noswapfile
" undo
set undofile
set undodir=~/.vimundo
set autoindent
set expandtab

if flavour == "buzz"
  set tabstop=2
  set shiftwidth=2
  set softtabstop=2
else
  set tabstop=4
  set shiftwidth=4
  set softtabstop=4
endif

" automatically round << and >> to shiftwidth
set shiftround

set incsearch
set hlsearch
" ignore case when searching
set ignorecase
" ... unless when there is a uppercase in the search
set smartcase
set nonumber
set ruler
set nolist
set clipboard=unnamed
set foldmethod=indent
set foldlevel=100
set scrolloff=3
" command completion more verbose
set wildmode=full
set wildmenu
" ignore certain files
set wildignore+=*.o,*.obj,.git,.hg,*.pyc
set winminheight=0 " when we max a window, other can be 1 line

" //////////////////////////////
" # key mappings
" //////////////////////////////
nnoremap ; :
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap jj <Esc>

" remaps Alt-[h,j,k,l] to resizing a window split
nnoremap <silent> <A-h> <C-w><
nnoremap <silent> <A-j> <C-W>-
nnoremap <silent> <A-k> <C-W>+
nnoremap <silent> <A-l> <C-w>>

" //////////////////////////////
" # leader key mappings
" //////////////////////////////
let mapleader = ","
map <Leader>u :GundoToggle<cr>
map <Leader>d :TagbarToggle<cr>
map <Leader>t :CommandT<cr>
map <leader>; :NERDTreeToggle<cr>
map <leader>: :NERDTreeMirror<cr>
map <Leader>y :YRShow<cr>
map <Leader>n :set number!<cr>
" convert newlines and retab
map <Leader>r :%s/\r/\r/g<cr>gg<cr>:retab<cr>
" removed whitespace in empty lines, and remove trailing whitespace
map <Leader>w :%s/^\s\+$//ge<cr>:%s/\(\S\)\s\+$/\1/ge<cr>
" Easy folding on search expr
map <silent><leader>z :set foldexpr=getline(v:lnum)!~@/ foldlevel=0 foldcolumn=0 foldmethod=expr<CR>
" Ack search for pattern recursively
map <leader>a :Ack

" //////////////////////////////
" filetype settings
" //////////////////////////////
autocmd BufWritePost *.coffee silent CoffeeMake! | cwindow
if flavour == "buzz"
  autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4
endif

" //////////////////////////////
" commands
" //////////////////////////////
command Rc e ~/.vimrc
command ClearUndo silent !rm ~/.vimundo/*
command SudoWrite w !sudo tee % > /dev/null
command JSHint !jshint % --show-non-errors
command -range=% Xmltidy <line1>,<line2>!tidy -xml -indent -utf8 -q --indent-spaces 2
command -range=% BeautifyJS <line1>,<line2>!js-beautify -i --indent-size=2
command -range=% UglifyJS <line1>,<line2>!uglifyjs

" //////////////////////////////
" plugin config
" //////////////////////////////

call pathogen#infect()
call pathogen#helptags()

let g:CommandTMaxHeight=25 " only show so many items
let g:CommandTMatchWindowReverse=1 " best match down
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:yankring_history_file = '.yankring_history'
let NERDTreeIgnore=['\.pyc$', '\~$']
let NERDTreeBookmarksFile = $HOME . '/.vim_nerdtree_bookmarks'
let NERDTreeWinSize=50
let NERDTreeShowBookmarks=1
let g:tagbar_compact=1
let g:molokai_original=1
let g:sparkupArgs = '--indent-spaces=2'

" //////////////////////////////
" gui
" //////////////////////////////
if has('gui_running')
    set guioptions=aAce
    set guifont=Menlo:h12
    set vb " no bells; as macvim does not support visual bell
    colorscheme molokai
end

" //////////////////////////////
" highlighting
" //////////////////////////////
highlight LineOverflow ctermbg=red ctermfg=white guibg=#592929
autocmd BufWinEnter * let w:m3=matchadd('LineOverflow', '\%>79v.\+', -1)

