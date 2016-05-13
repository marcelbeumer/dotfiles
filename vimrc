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
Plug 'gcmt/taboo.vim'

" Language support
" ----------------
Plug 'elzr/vim-json'
Plug 'marcelbeumer/javascript-syntax.vim'
Plug 'gavocanov/vim-js-indent'
Plug 'lepture/vim-jinja'

" Text editing tools
" ------------------
Plug 'Valloric/YouCompleteMe', {'do': './install.py --tern-completer'}
Plug 'SirVer/ultisnips'
Plug 'marcelbeumer/vim-snippets'
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
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'bling/vim-airline'

" Colors
" ------
Plug 'flazz/vim-colorschemes'
Plug 'chriskempson/base16-vim'
Plug 'marcelbeumer/spacedust.vim'
Plug 'marcelbeumer/spacedust-airline.vim'

" Misc
" ----
Plug 'marcelbeumer/internations.vim'

call plug#end()
runtime macros/matchit.vim


" Functions
" ---------
function! FlowCheck()
  let output = system('flow > /tmp/flow_output')
  silent pedit /tmp/flow_output
endfunction

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
nmap th :tabprev<cr>
nmap tl :tabnext<cr>
nmap tn :tabnew<cr>
nmap tc :tabclose<cr>
nmap <leader>; :NERDTreeToggle<cr>
nmap <leader>b :CtrlPBuffer<cr>
nmap <leader>x :pclose<cr>
nmap <leader>git :Grepper -tool git -open -switch
nmap <leader>ag  :Grepper -tool ag  -open -switch
nmap <leader>*   :Grepper -tool ag -cword -noprompt<cr>
" Convert newlines and retab
nmap <Leader>r :%s/\r/\r/g<cr>gg<cr>:retab<cr>
" Removed whitespace in empty lines, and remove trailing whitespace
nmap <Leader>w :%s/^\s\+$//ge<cr>:%s/\(\S\)\s\+$/\1/ge<cr>
" Easy folding on search expr
nmap <silent><leader>z :set foldexpr=getline(v:lnum)!~@/ foldlevel=0 foldcolumn=0 foldmethod=expr<CR>
noremap <c-j> 15gj
noremap <c-k> 15gk

" Filetype settings
" -----------------
set omnifunc=syntaxcomplete#Complete
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType javascript setlocal omnifunc=tern#Complete
autocmd Filetype javascript nmap <leader>t :call FlowCheck()<cr> | setlocal path+=node_modules/
autocmd Filetype html nmap <leader>t :call FlowCheck()<cr>
autocmd Filetype twig set ft=jinja
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
command FilePath let @*=@%
command DirPath let @*=expand("%:h")
command Dark colorscheme spacedust | set background=dark
command Light colorscheme solarized | set background=light

" Plugin config
" -------------
let g:neomake_javascript_enabled_makers = ['eslint_d', 'flow']
let g:internations_root = '/Users/marcel/dev/clone/in/in'
let g:vim_json_syntax_conceal = 0
let NERDTreeIgnore=['\.pyc$', '__pycache__', '\~$', 'npm-debug.log*']
let g:ctrlp_map = '<leader>p'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_current_file = 1
let g:ctrlp_user_command = ['.git', 'git ls-files %s --exclude-standard', 'find %s -type f']
let g:ctrlp_match_window = 'max:20,results:50'
let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-shift-b>"

let flow_mapexpr = 'substitute(v:val, "\\\\n", " ", "g")'
let g:neomake_javascript_flow_maker = {
\ 'args': ['--old-output-format'],
\ 'errorformat': '%f:%l:%c\,%n: %m',
\ 'mapexpr': flow_mapexpr,
\ }

" Setup UI
" --------
set guifont=Meslo\ LG\ S\ DZ:h12
execute "Dark"
