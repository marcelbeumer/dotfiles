set nocompatible
filetype off

runtime macros/matchit.vim
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" Themes
" ------
Bundle 'altercation/vim-colors-solarized'
Bundle 'marcelbeumer/spacedust.vim'
Bundle 'mrtazz/molokai.vim'

" Language support
" ----------------
Bundle 'beyondwords/vim-twig'
Bundle 'django.vim'
Bundle 'docteurklein/vim-symfony'
Bundle 'groenewege/vim-less'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'kchmck/vim-coffee-script'
Bundle 'marcelbeumer/javascript-syntax.vim'
Bundle 'nono/vim-handlebars'
Bundle 'othree/coffee-check.vim'
Bundle 'skammer/vim-css-color'

" General language tools
" ----------------------
Bundle 'scrooloose/syntastic'

" Text editing tools
" ------------------
Bundle 'SirVer/ultisnips'
Bundle 'bitc/vim-bad-whitespace'
Bundle 'godlygeek/tabular'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'

" Navigation, search, GUI
" -----------------------
Bundle 'ZoomWin'
Bundle 'ack.vim'
Bundle 'nelstrom/vim-qargs'
Bundle 'marcelbeumer/color-color.vim'
Bundle 'marcelbeumer/genutils'
Bundle 'marcelbeumer/gotofile'
Bundle 'scrooloose/nerdtree'
Bundle 'sjl/gundo.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'ervandew/supertab'

" Version control
" ---------------
Bundle 'tpope/vim-fugitive'

" Misc
" ----
Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-notes'
Bundle 'xolox/vim-reload'

syntax enable
filetype plugin indent on

" Options
" -------
set shortmess=I
set hidden
set nobackup
set noswapfile
set undofile
set undodir=~/.vimundo
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftround
set incsearch
set number
set numberwidth=5
set ruler
set foldmethod=indent
set foldlevel=100
set scrolloff=10
set wildmenu
set wildignore+=*.o,*.obj,.git,.hg,*.pyc
set timeoutlen=500 " timeout of leader key
set suffixesadd+=.js "suffix added when 'gf'

" Key mappings
" ------------
nmap <silent> gf :GotoFile<CR>
nmap <leader>; :NERDTreeToggle<cr>
nmap <leader>: :NERDTreeMirror<cr>
nmap <leader>t :CtrlPTag<cr>
nmap <leader>b :CtrlPBuffer<cr>
" Convert newlines and retab
nmap <Leader>r :%s/\r/\r/g<cr>gg<cr>:retab<cr>
" Removed whitespace in empty lines, and remove trailing whitespace
nmap <Leader>w :%s/^\s\+$//ge<cr>:%s/\(\S\)\s\+$/\1/ge<cr>
" Easy folding on search expr
nmap <silent><leader>z :set foldexpr=getline(v:lnum)!~@/ foldlevel=0 foldcolumn=0 foldmethod=expr<CR>
" Colors
nmap <Leader><leader>c :ColorColorToggle<cr>
" CoffeeScript
" vmap <leader>c <esc>:'<,'>:CoffeeCompile<CR>
" map <leader>c :CoffeeCompile<CR>

" Filetype settings
" -----------------
let coffee_make_options = '-o /tmp/'
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd BufNewFile,BufRead,BufWritePost *.md set filetype=markdown

set omnifunc=syntaxcomplete#Complete
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Commands
" --------
command Rc e ~/.vimrc
command ClearUndo silent !rm ~/.vimundo/*
command JournalDate silent r !date +\%a\ \%d\ \%B\ \%Y\ \%H:\%M
command SudoWrite w !sudo tee % > /dev/null
command JSHint !jshint % --show-non-errors
command -range=% Xmltidy <line1>,<line2>!tidy -xml -indent -utf8 -q --indent-spaces 4
command -range=% BeautifyJS <line1>,<line2>!js-beautify --indent-size=4 -
command -range=% UglifyJS <line1>,<line2>!uglifyjs
command Marked silent !/Applications/Marked.app/Contents/MacOS/Marked "%" &
command InTechNote Note Internations Tech

" Plugin config
" -------------
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_html_checkers=[]
let g:syntastic_scss_checkers=[]
let g:yankring_history_file = '.yankring_history'
let NERDTreeIgnore=['\.pyc$', '\~$']
let NERDTreeBookmarksFile = $HOME . '/.vim_nerdtree_bookmarks'
let NERDTreeWinSize=50
let NERDTreeShowBookmarks=1
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:notes_directories = ['~/Documents/Notes']
let g:notes_title_sync = 'change_title'
let g:notes_suffix = '.txt'
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP .'
let g:ctrlp_regexp = 1
let g:ctrlp_lazy_update = 500
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:20'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_extensions = ['tag']
let g:SuperTabDefaultCompletionType = "<c-n>"

" Gui
" ---
if has('gui_running')
    set guioptions=aAce
    set guifont=Meslo\ LG\ S\ DZ:h12
    set vb " no bells; as macvim does not support visual bell
    " set background=light
    colorscheme solarized
    colorscheme spacedust
end
