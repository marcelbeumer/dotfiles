set termguicolors
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
Plug 'pangloss/vim-javascript'
Plug 'vim-scripts/JavaScript-Indent'
Plug 'mxw/vim-jsx'
Plug 'reasonml-editor/vim-reason'

" Text editing tools
" ------------------
Plug 'flowtype/vim-flow', {'filetypes': 'javascript'}
Plug 'Valloric/YouCompleteMe', {'do': './install.py'}
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
Plug 'marcelbeumer/spacedust.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'jordwalke/VimCleanColors'
Plug 'jordwalke/vim-one'
Plug 'tyrannicaltoucan/vim-deep-space'

" Misc
" ----

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
set autoread " automatically read changed files
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set hidden
set foldmethod=indent
set foldlevel=100
set ignorecase
set noswapfile
set shortmess=atI
set suffixesadd+=.js
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set laststatus=2 " always show status bar
set nowritebackup " place nice with file watchers
set clipboard=unnamed
set hlsearch
set number

map <C-s> :w<cr>
imap <C-s> <Esc>:w<cr>
nmap th :tabprev<cr>
nmap tl :tabnext<cr>
nmap tn :tabnew<cr>
nmap tc :tabclose<cr>
nmap <leader>f :Prettier<cr>
nmap <leader>; :NERDTreeToggle<cr>
nmap <leader>b :CtrlPBuffer<cr>
nmap <leader>x :pclose<cr>
" Line number toggle
nmap <leader>n :set number! <cr>
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
autocmd Filetype javascript nmap <leader>t :call FlowCheck()<cr> | setlocal path+=node_modules/
autocmd FileType javascript.jsx,javascript setlocal formatprg=prettier\ --stdin\ --single-quote
" autocmd FileType javascript.jsx,javascript setlocal formatprg=prettier\ --stdin\ --single-quote\ --trailing-comma\ es5
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
command Prettier exe "normal! gggqG\<C-o>\<C-o>"

" Macros
" ------
let @c='yiwoconsole.log('''', );bblplllp'

" Plugin config
" -------------
let g:javascript_plugin_flow = 1
let g:airline_theme='one'
let g:airline_powerline_fonts = 0
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:neomake_javascript_enabled_makers = ['eslint_d', 'flow']
let g:neomake_jsx_enabled_makers = ['eslint_d', 'flow']
let g:neomake_error_sign = {'text': 'x', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': 'x', 'texthl': 'NeomakeWarningSign'}
let g:neomake_message_sign = {'text': 'x', 'texthl': 'NeomakeMessageSign' }
let g:neomake_info_sign = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}
let g:vim_json_syntax_conceal = 0
let NERDTreeIgnore=['\.pyc$', '__pycache__', '\~$', 'npm-debug.log*']
let g:ctrlp_map = '<leader>p'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_current_file = 1
let g:ctrlp_user_command = ['.git', 'git ls-files %s --exclude-standard', 'find %s -type f']
let g:ctrlp_match_window = 'max:50,results:50'
let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-shift-b>"
let g:flow#enable = 0 " Only want the autocomplete
let g:jsx_ext_required = 0

" Setup UI
" --------
set guioptions-=rL
" set guifont=Menlo:h13
set guifont=Inconsolata-dz\ for\ Powerline:h12
" set guifont=SF\ Mono:h12
set background=dark
" colorscheme spacegray
colorscheme one
