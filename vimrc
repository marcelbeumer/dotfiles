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
Plug 'arecarn/crunch'
Plug 'nelstrom/vim-qargs'

" Version control
" ---------------
Plug 'tpope/vim-fugitive'

" Navigation, search, GUI
" -----------------------
Plug 'kien/ctrlp.vim'
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
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set hidden
set foldmethod=indent
set foldlevel=100
set number
set ignorecase
set noswapfile
set shortmess=atI
set suffixesadd+=.js
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set laststatus=2 " always show status bar
set nowritebackup " place nice with file watchers
set clipboard=unnamed

map <C-s> :w<cr>
imap <C-s> <Esc>:w<cr>
nnoremap th :tabprev<cr>
nnoremap tl :tabnext<cr>
nnoremap tn :tabnew<cr>
nnoremap tc :tabclose<cr>
nmap <leader>; :NERDTreeToggle<cr>
nmap <leader>f :let @*=@%<cr>
nmap <leader>h :let @*=expand("%:h")<cr>
nnoremap <leader>git :Grepper -tool git -open -switch
nnoremap <leader>ag  :Grepper -tool ag  -open -switch
nnoremap <leader>*   :Grepper -tool ag -cword -noprompt<cr>
" Convert newlines and retab
nmap <Leader>r :%s/\r/\r/g<cr>gg<cr>:retab<cr>
" Removed whitespace in empty lines, and remove trailing whitespace
nmap <Leader>w :%s/^\s\+$//ge<cr>:%s/\(\S\)\s\+$/\1/ge<cr>
" Easy folding on search expr
nmap <silent><leader>z :set foldexpr=getline(v:lnum)!~@/ foldlevel=0 foldcolumn=0 foldmethod=expr<CR>

" Filetype settings
" -----------------
set omnifunc=syntaxcomplete#Complete
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType javascript setlocal omnifunc=tern#Complete
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
command Dark colorscheme spacedust | set background=dark
command Light colorscheme solarized | set background=light

" Plugin config
" -------------
let g:neomake_javascript_enabled_makers = ['eslint_d', 'flow']
let g:vim_json_syntax_conceal = 0
let NERDTreeIgnore=['\.pyc$', '__pycache__', '\~$', 'npm-debug.log*']
let g:ctrlp_map = '<leader>p'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --exclude-standard', 'find %s -type f']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
  \ }

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
set guifont=Meslo\ LG\ S\ DZ:h12
execute "Dark"
