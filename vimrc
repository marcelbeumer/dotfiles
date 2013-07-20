" //////////////////////////////
" # vim settings
" //////////////////////////////
set nocompatible
filetype off

runtime macros/matchit.vim
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" Themes
Bundle 'altercation/vim-colors-solarized'
Bundle 'marcelbeumer/spacedust.vim'
Bundle 'mrtazz/molokai.vim'

" Language support
Bundle 'beyondwords/vim-twig'
Bundle 'docteurklein/vim-symfony'
Bundle 'groenewege/vim-less'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'marcelbeumer/javascript-syntax.vim'
Bundle 'skammer/vim-css-color'
" Bundle 'sukima/xmledit'
" Bundle 'django.vim'
" Bundle 'nono/vim-handlebars'
" Bundle 'kchmck/vim-coffee-script'
" Bundle 'othree/coffee-check.vim'

" General language tools
Bundle 'scrooloose/syntastic'

" Text editing tools
Bundle 'Lokaltog/vim-easymotion'
Bundle 'SirVer/ultisnips'
Bundle 'bitc/vim-bad-whitespace'
Bundle 'godlygeek/tabular'
Bundle 'tComment'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
" Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
" Bundle 'Valloric/YouCompleteMe'

" Navigation, search, GUI
Bundle 'Tagbar'
Bundle 'ZoomWin'
Bundle 'ack.vim'
Bundle 'marcelbeumer/color-color.vim'
Bundle 'marcelbeumer/genutils'
Bundle 'marcelbeumer/gotofile'
Bundle 'scrooloose/nerdtree'
Bundle 'sjl/gundo.vim'
Bundle 'wincent/Command-T'
" Bundle 'lirazsiri/vim-smartopen', {'rtp': 'vimfiles/'}
" Bundle 'gorkunov/smartgf.vim'
" Bundle 'xolox/vim-session'
" Bundle 'rizzatti/funcoo.vim'
" Bundle 'rizzatti/greper.vim'
" Bundle 'rizzatti/dash.vim'

" Version conrol
Bundle 'vcscommand.vim'

" Misc
Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-notes'
" Bundle 'xolox/vim-reload'
" Bundle 'xolox/vim-easytags'

syntax enable
filetype plugin indent on

" Turn off Bram's message
set shortmess=I

" set macmeta " Set left and right option/alt keys to be meta keys
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

" tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=4

" automatically round << and >> to shiftwidth
set shiftround

set incsearch
set hlsearch
" ignore case when searching
set ignorecase
" ... unless when there is a uppercase in the search
set smartcase
set number
set numberwidth=5
set ruler
set nolist
" set clipboard=unnamed
set foldmethod=indent
set foldlevel=100
set scrolloff=3
" command completion more verbose
set wildmode=full
set wildmenu
" ignore certain files
set wildignore+=*.o,*.obj,.git,.hg,*.pyc
set winminheight=0 " when we max a window, other can be 1 line
set timeoutlen=500 " timeout of leader key
set suffixesadd+=.js "suffix added when 'gf'

" //////////////////////////////
" # key mappings
" //////////////////////////////
" nnoremap ; :
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
noremap \ ,
map <Leader>d :TagbarToggle<cr>
map <Leader>t :CommandT<cr>
map <leader>; :NERDTreeToggle<cr>
map <leader>: :NERDTreeMirror<cr>
map <Leader>a :Ack <cword><cr>
map <Leader>n :set number!<cr>
" convert newlines and retab
map <Leader>r :%s/\r/\r/g<cr>gg<cr>:retab<cr>
" removed whitespace in empty lines, and remove trailing whitespace
map <Leader>w :%s/^\s\+$//ge<cr>:%s/\(\S\)\s\+$/\1/ge<cr>
" Easy folding on search expr
map <silent><leader>z :set foldexpr=getline(v:lnum)!~@/ foldlevel=0 foldcolumn=0 foldmethod=expr<CR>
" Colors
map <Leader><leader>c :ColorColorToggle<cr>
" CoffeeScript
" vmap <leader>c <esc>:'<,'>:CoffeeCompile<CR>
" map <leader>c :CoffeeCompile<CR>
nmap <silent> gf :GotoFile<CR>

" //////////////////////////////
" filetype settings
" //////////////////////////////
" autocmd BufWritePost *.coffee silent CoffeeMake! | cwindow
let coffee_make_options = '-o /tmp/'
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd BufNewFile,BufRead,BufWritePost *.md set filetype=markdown

" //////////////////////////////
" commands
" //////////////////////////////
command Rc e ~/.vimrc
" command CodingLog e ~/Documents/Journaling/coding.md
command ClearUndo silent !rm ~/.vimundo/*
command JournalDate silent r !date +\%a\ \%d\ \%B\ \%Y\ \%H:\%M

command SudoWrite w !sudo tee % > /dev/null
command JSHint !jshint % --show-non-errors
command -range=% Xmltidy <line1>,<line2>!tidy -xml -indent -utf8 -q --indent-spaces 4
command -range=% BeautifyJS <line1>,<line2>!js-beautify --indent-size=4 -
command -range=% UglifyJS <line1>,<line2>!uglifyjs
command Marked silent !/Applications/Marked.app/Contents/MacOS/Marked "%" &

" //////////////////////////////
" plugin config
" //////////////////////////////
let g:CommandTMaxHeight=10 " only show so many items
let g:CommandTMatchWindowReverse=1 " best match down
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_html_checkers=[]
let g:syntastic_scss_checkers=[]
let g:yankring_history_file = '.yankring_history'
let NERDTreeIgnore=['\.pyc$', '\~$']
let NERDTreeBookmarksFile = $HOME . '/.vim_nerdtree_bookmarks'
let NERDTreeWinSize=50
let NERDTreeShowBookmarks=1
" let NERDTreeMouseMode=3
let g:tagbar_compact=1
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
let g:sparkupArgs = '--indent-spaces=4'
let g:session_autosave = 'no'
let g:session_autoload = 'no'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:ycm_key_list_select_completion = ['<enter>', '<Down>']
let g:ycm_key_list_previous_completion = ['<s-enter>', '<Up>']
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_filetype_specific_completion_to_disable = {
          \ 'javascript' : 1,
          \}
let g:ycm_filetype_blacklist = {
          \ 'notes' : 1,
          \ 'markdown' : 1,
          \ 'text' : 1,
          \}
:let g:notes_directories = ['~/Documents/NotesVim']

" //////////////////////////////
" gui
" //////////////////////////////
if has('gui_running')
    set guioptions=aAce
    set guifont=Meslo\ LG\ S\ DZ:h12
    set vb " no bells; as macvim does not support visual bell

    set background=light
    colorscheme solarized
    " colorscheme spacedust
end

