let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let g:python_host_prog = '/usr/bin/python2'

set nocompatible
call plug#begin('~/.nvim/plugged')

" General
" -------
Plug 'editorconfig/editorconfig-vim'

" Language support
" ----------------
Plug 'groenewege/vim-less'
Plug 'kchmck/vim-coffee-script'
Plug 'othree/coffee-check.vim'
Plug 'gkz/vim-ls'
Plug 'marcelbeumer/javascript-syntax.vim'
Plug 'beyondwords/vim-twig'

" Text editing tools
" ------------------
Plug 'Valloric/YouCompleteMe', {'do': './install.sh'}
Plug 'bitc/vim-bad-whitespace'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" Version control
" ---------------
Plug 'tpope/vim-fugitive'

" Math
" ----
Plug 'arecarn/crunch'

" Navigation, search, GUI
" -----------------------
Plug 'ZoomWin'
Plug 'ack.vim'
Plug 'kien/ctrlp.vim'
Plug 'marcelbeumer/color-color.vim'
Plug 'nelstrom/vim-qargs'
Plug 'scrooloose/nerdtree'
Plug 'sjl/gundo.vim'
" Plug 'bling/vim-airline'

" Colors
" ------
Plug 'flazz/vim-colorschemes'
Plug 'marcelbeumer/spacedust.vim'
Plug 'marcelbeumer/spacedust-airline.vim'
Plug 'morhetz/gruvbox'
Plug 'carlson-erik/wolfpack'
Plug 'gosukiwi/vim-atom-dark'
Plug 'vim-scripts/BusyBee'
Plug 'croaker/mustang-vim'

call plug#end()
runtime macros/matchit.vim

" Options
" -------
set autoindent
set number
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
set tabstop=2
set timeoutlen=500 " timeout of leader key
set undodir=~/.vimundo
set undofile
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*        " Linux/MacOSX
set wildmenu
set laststatus=2 " always show status bar
let &colorcolumn="80,".join(range(120,999),",")
set splitbelow " so that preview window positions below
set splitright
set nowritebackup " place nice with file watchers
2+2
" Plugin triggers
nmap <Leader><leader>c :ColorColorToggle<cr>
nmap <leader>: :NERDTreeMirror<cr>
nmap <leader>; :NERDTreeToggle<cr>
nmap <leader>b :CtrlPBuffer<cr>
nmap <leader>t :CtrlPTag<cr>
nmap <leader>m :CtrlPMRUFiles<cr>
nmap <leader>f :let @*=@%<cr>
nmap <leader>h :let @*=expand("%:h")<cr>

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
autocmd BufNewFile,BufRead,BufWritePost *.html set filetype=html.twig
autocmd BufNewFile,BufRead,BufWritePost *.html.swig set filetype=html.twig

set omnifunc=syntaxcomplete#Complete
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Commands
" --------
command -range=% BeautifyJS <line1>,<line2>!js-beautify --indent-size=2 -f -
command -range=% UglifyJS <line1>,<line2>!uglifyjs
command -range=% Xmltidy <line1>,<line2>!tidy -xml -indent -utf8 -q --indent-spaces 4
command JournalDate silent r !date +\%a\ \%d\ \%B\ \%Y\ \%Hh\%M
command Nf NERDTreeFind
command Rc e ~/.vimrc
command Rr silent! so $MYVIMRC
command SudoWrite w !sudo tee % > /dev/null
command -nargs=* Glp Glog --abbrev-commit --date=relative <args>

" Plugin config
" -------------
let g:netrw_liststyle = 3
let NERDTreeBookmarksFile = $HOME . '/.vim_nerdtree_bookmarks'
let NERDTreeIgnore=['\.pyc$', '__pycache__', '\~$', 'npm-debug.log*']
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
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
  \ }
let g:syntastic_auto_loc_list=2
let g:syntastic_enable_signs=1
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_html_checkers=[]
let g:syntastic_php_checkers=['php'] ", 'phpcs']
let g:syntastic_scss_checkers=[]
let g:syntastic_less_checkers=[]
let g:syntastic_yaml_checkers=[]
let g:fugitive_summary_format = '%h - %d %s (%cr by %an)'
let g:indent_guides_auto_colors = 0

" Setup UI
" --------
set vb " no bells; as macvim does not support visual bell
set guioptions=aAc "add 'e' for native tabs
set guifont=Meslo\ LG\ S\ DZ:h12
set background=light
colorscheme spacedust
