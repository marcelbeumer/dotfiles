let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let g:python_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

" Plugins
" -------
call plug#begin('~/.vim/plugged')

" General
" -------
Plug 'editorconfig/editorconfig-vim'
Plug 'benekastah/neomake'

" Language support
" ----------------
Plug 'elzr/vim-json'
Plug 'marcelbeumer/javascript-syntax.vim'
Plug 'marijnh/tern_for_vim', { 'do': 'npm install' }

" Text editing tools
" ------------------
Plug 'Valloric/YouCompleteMe', {'do': './install.sh'}
Plug 'SirVer/ultisnips'
Plug 'bitc/vim-bad-whitespace'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'mhinz/vim-grepper'

" Version control
" ---------------
Plug 'tpope/vim-fugitive'

" Math
" ----
Plug 'arecarn/crunch'

" Navigation, search, GUI
" -----------------------
Plug 'kien/ctrlp.vim'
Plug 'nelstrom/vim-qargs'
Plug 'scrooloose/nerdtree'
Plug 'bling/vim-airline'
"
" " Colors
" " ------
Plug 'flazz/vim-colorschemes'
Plug 'marcelbeumer/spacedust.vim'
Plug 'marcelbeumer/spacedust-airline.vim'

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
" let &colorcolumn="100,".join(range(120,999),",")
set splitbelow " so that preview window positions below
set splitright
set nowritebackup " place nice with file watchers

map <C-s> :w<cr>
imap <C-s> <Esc>:w<cr>
tnoremap <Leader>e <C-\><C-n>
nnoremap th :tabprev<cr>
nnoremap tl :tabnext<cr>
nnoremap tn :tabnew<cr>
nnoremap tc :tabclose<cr>
nmap <Leader><leader>c :ColorColorToggle<cr>
nmap <leader>; :NERDTreeToggle<cr>
nmap <leader>b :CtrlPBuffer<cr>
nmap <leader>t :CtrlPTag<cr>
nmap <leader>m :CtrlPMRUFiles<cr>
nmap <leader>f :let @*=@%<cr>
nmap <leader>h :let @*=expand("%:h")<cr>
nnoremap <leader>git :Grepper! -tool git -open -switch
nnoremap <leader>ag  :Grepper! -tool ag  -open -switch
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
autocmd FileType javascript setlocal omnifunc=tern#Complete
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd! BufWritePost * Neomake

" Commands
" --------
command W w
command -range=% BeautifyJS <line1>,<line2>!js-beautify --indent-size=2 -f -
command -range=% UglifyJS <line1>,<line2>!uglifyjs
command -range=% Xmltidy <line1>,<line2>!tidy -xml -indent -utf8 -q --indent-spaces 4
command JournalDate silent r !date +\%a\ \%d\ \%B\ \%Y\ \%Hh\%M
command Nf NERDTreeFind
command Rc e ~/.vimrc
command Rr silent! so $MYVIMRC
command SudoWrite w !sudo tee % > /dev/null
command -nargs=* Glp Glog --abbrev-commit --date=relative <args>
command Dark colorscheme spacedust | set background=dark
" command Dark colorscheme zazen | set background=dark
command Light colorscheme solarized | set background=light

" Plugin config
" -------------
let NERDTreeIgnore=['\.pyc$', '__pycache__', '\~$', 'npm-debug.log*']
let NERDTreeShowBookmarks=0
let NERDTreeWinSize=50
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
let g:neomake_javascript_enabled_makers = ['eslint_d', 'flow']
let g:fugitive_summary_format = '%h - %d %s (%cr by %an)'
let g:UltiSnipsExpandTrigger = '<c-j>'
let g:UltiSnipsJumpForwardTrigger = "<c-h>"
let g:UltiSnipsJumpBackwardTrigger = '<c-l>'

" Modification removing 'check' arg
function! neomake#makers#ft#javascript#flow()
    let mapexpr = 'substitute(v:val, "\\\\n", " ", "g")'
    return {
        \ 'args': ['--old-output-format'],
        \ 'errorformat': '%f:%l:%c\,%n: %m',
        \ 'mapexpr': mapexpr,
        \ }
endfunction

" Setup UI
" --------
set vb " no bells; as macvim does not support visual bell
set guioptions=aAc "add 'e' for native tabs
set guifont=Meslo\ LG\ S\ DZ:h12
execute "Dark"
