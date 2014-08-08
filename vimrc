set nocompatible
filetype off

set rtp+=~/.fzf

runtime macros/matchit.vim
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" General
" -------
Bundle 'Shougo/vimproc'

" Themes
" ------
Bundle 'flazz/vim-colorschemes'
Bundle 'marcelbeumer/spacedust.vim'
Bundle 'marcelbeumer/spacedust-airline.vim'

" Language support
" ----------------
Bundle 'arnaud-lb/vim-php-namespace'
Bundle 'beyondwords/vim-twig'
Bundle 'django.vim'
Bundle 'groenewege/vim-less'
Bundle 'kchmck/vim-coffee-script'
Bundle 'marcelbeumer/javascript-syntax.vim'
Bundle 'othree/coffee-check.vim'
Bundle 'plasticboy/vim-markdown'
Bundle 'moll/vim-node'
Bundle 'marijnh/tern_for_vim'
Bundle 'mustache/vim-mustache-handlebars'
" Bundle 'mxw/vim-jsx'
" Bundle 'm2mdas/phpcomplete-extended'

" General language tools
" ----------------------
Bundle 'scrooloose/syntastic'

" Text editing tools
" ------------------
Bundle 'Valloric/YouCompleteMe'
Bundle 'bitc/vim-bad-whitespace'
Bundle 'godlygeek/tabular'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'marcelbeumer/vis.vim'
Bundle 'marcelbeumer/dragvisuals.vim'

" Version control
" ---------------
Bundle 'tpope/vim-fugitive'

" Math
" ----
Bundle 'arecarn/crunch'
Bundle 'marcelbeumer/vmath.vim'

" Navigation, search, GUI
" -----------------------
Bundle 'bling/vim-airline'
Bundle 'ZoomWin'
Bundle 'ack.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'marcelbeumer/color-color.vim'
Bundle 'nelstrom/vim-qargs'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-vinegar'
Bundle 'sjl/gundo.vim'

" " Misc
" " ----
Bundle 'marcelbeumer/editing-modes.vim'
Bundle 'marcelbeumer/filetype-magic.vim'

syntax enable
filetype plugin indent on

" Options
" -------
set autoindent
set clipboard=unnamed
set expandtab
set foldlevel=100
set foldmethod=indent
set hidden
set incsearch
set hls
set ignorecase
set nobackup
set noswapfile
set numberwidth=5
set ruler
set scrolloff=10
set shiftround
set shiftwidth=2
set shortmess=atI
set softtabstop=2
set suffixesadd+=.js
set suffixesadd+=.php
set tabstop=2
set timeoutlen=500 " timeout of leader key
set undodir=~/.vimundo
set undofile
set wildignore+=*.o,*.obj,.git,.hg,*.pyc
set wildmenu
set laststatus=2 " always show status bar
let &colorcolumn="80,".join(range(120,999),",")
set splitbelow " so that preview window positions below
set splitright
set nowritebackup " place nice with file watchers

" Key mappings
" ------------

" Window navigation
" map <C-h> <C-w>h
" map <C-j> <C-w>j
" map <C-k> <C-w>k
" map <C-l> <C-w>l

" Omnicomplet with C-Space
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>

" Plugin triggers
map <leader>s :!webkitdev<cr>
map  <leader>c :CoffeeCompile<CR>
map  <leader>g :call EditIncludeOnLine()<CR>
nmap <Leader><leader>c :ColorColorToggle<cr>
nmap <leader>: :NERDTreeMirror<cr>
nmap <leader>; :NERDTreeToggle<cr>
nmap <leader>b :CtrlPBuffer<cr>
nmap <leader>t :CtrlPTag<cr>
nmap <leader>m :CtrlPMRUFiles<cr>
nmap <leader>f :let @*=@%<cr>
nmap <leader>h :let @*=expand("%:h")<cr>
vmap <leader>c <esc>:'<,'>:CoffeeCompile<CR>
vmap <expr> <LEFT> DVB_Drag('left')
vmap <expr> <RIGHT> DVB_Drag('right')
vmap <expr> <DOWN> DVB_Drag('down')
vmap <expr> <UP> DVB_Drag('up')
vmap <expr> D DVB_Duplicate()
vmap <expr> ++ VMATH_YankAndAnalyse()
nmap ++ vip++

" Convert newlines and retab
nmap <Leader>r :%s/\r/\r/g<cr>gg<cr>:retab<cr>

" Removed whitespace in empty lines, and remove trailing whitespace
nmap <Leader>w :%s/^\s\+$//ge<cr>:%s/\(\S\)\s\+$/\1/ge<cr>

" Easy folding on search expr
nmap <silent><leader>z :set foldexpr=getline(v:lnum)!~@/ foldlevel=0 foldcolumn=0 foldmethod=expr<CR>

" Filetype settings
" -----------------
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType coffee setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufNewFile,BufRead,BufWritePost *.md set filetype=markdown

set omnifunc=syntaxcomplete#Complete
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Commands
" --------
command -range=% BeautifyJS <line1>,<line2>!js-beautify --indent-size=4 -
command -range=% UglifyJS <line1>,<line2>!uglifyjs
command -range=% Xmltidy <line1>,<line2>!tidy -xml -indent -utf8 -q --indent-spaces 4
command JSHint !jshint % --show-non-errors
command PHPExpandClass call PhpExpandClass()
command Phpcs !vendor/bin/phpcs % --standard=ruleset.xml
command JournalDate silent r !date +\%a\ \%d\ \%B\ \%Y\ \%Hh\%M
command Marked silent !/Applications/Marked.app/Contents/MacOS/Marked "%" &
command Nf NERDTreeFind
command Rc e ~/.vimrc
command Rr silent! so $MYVIMRC
command SudoWrite w !sudo tee % > /dev/null
command Notes lcd ~/Documents/Notes
command Clones lcd ~/Development/Clones
command InApp lcd ~/Development/Clones/Internations/in
command -nargs=* Glp Glog --abbrev-commit --date=relative <args>
command TernReset call tern#Disable() | call tern#Shutdown() | call tern#Enable()

" Plugin config
" -------------
let g:netrw_liststyle = 3
let NERDTreeBookmarksFile = $HOME . '/.vim_nerdtree_bookmarks'
let NERDTreeIgnore=['\.pyc$', '\~$']
let NERDTreeShowBookmarks=1
let NERDTreeWinSize=50
let coffee_make_options = '-o /tmp/'
let g:ackprg = 'ag --nogroup --nocolor --column'
let g:ctrlp_cmd = 'CtrlP .'
let g:ctrlp_extensions = ['tag']
let g:ctrlp_lazy_update = 150
let g:ctrlp_use_caching = 1
let g:ctrlp_map = '<leader>p'
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:20'
let g:ctrlp_regexp = 1
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --exclude-standard', 'find %s -type f']
let g:syntastic_auto_loc_list=2
let g:syntastic_enable_signs=1
" let g:syntastic_javascript_checkers=['jsxhint']
let g:syntastic_html_checkers=[]
let g:syntastic_php_checkers=['php'] ", 'phpcs']
let g:syntastic_scss_checkers=[]
let g:syntastic_less_checkers=[]
let g:syntastic_yaml_checkers=[]
let g:fugitive_summary_format = '%h - %d %s (%cr by %an)'
let g:DVB_TrimWS=0 " no trim whitespace after moving
let g:airline_theme='spacedust'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:ycm_min_num_of_chars_for_completion = 99
let g:ycm_filetype_specific_completion_to_disable = {'php': 1}

" Setup UI
" --------
if has('gui_running')
    set vb " no bells; as macvim does not support visual bell
    set guioptions=aAc "add 'e' for native tabs
    set background=light
    colorscheme spacedust
    " colorscheme solarized
end

" Default mode
silent! call editing_modes#CodingMode()

let g:fzf_launcher = 'urxvt -geometry 120x30 -e sh -c %s'
