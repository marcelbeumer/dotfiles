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
Bundle 'flazz/vim-colorschemes'

" Language support
" ----------------
Bundle 'beyondwords/vim-twig'
Bundle 'django.vim'
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
Bundle 'tpope/vim-unimpaired'
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
set shortmess=atI
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
set numberwidth=5
set ruler
set foldmethod=indent
set foldlevel=100
set scrolloff=10
set wildmenu
set wildignore+=*.o,*.obj,.git,.hg,*.pyc
set timeoutlen=500 " timeout of leader key
set clipboard=unnamed
set suffixesadd+=.php
set suffixesadd+=.js

" Key mappings
" ------------
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" nmap <silent> gf :GotoFile<CR>
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
vmap <leader>c <esc>:'<,'>:CoffeeCompile<CR>
map <leader>c :CoffeeCompile<CR>

" Filetype settings
" -----------------
function! PHPSettings()
    " TODO: add support for @Bundle/foo/bar syntax (might need to use other
    " thing instead of substitute
    setlocal includeexpr=substitute(v:fname,'\\\','/','g')
    setlocal path+=app-new/src/**
    setlocal path+=vendor/sensio/**
    setlocal path+=vendor/twig/**
    setlocal path+=vendor/symfony/**
    setlocal path+=vendor/doctrine/**
endfunction

autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd BufNewFile,BufRead,BufWritePost *.md set filetype=markdown

set omnifunc=syntaxcomplete#Complete
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType php call PHPSettings()

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
command INTech Note IN - Tech
command INJournal Note IN - Journal
command IN e build.xml
command Nf NERDTreeFind
command Phpcs !vendor/bin/phpcs % --standard=ruleset.xml
command WriterMode silent! call WriterMode()
command CodingMode silent! call CodingMode()

" Plugin config
" -------------
let coffee_make_options = '-o /tmp/'
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_html_checkers=[]
let g:syntastic_scss_checkers=[]
let g:syntastic_php_checkers=['php'] ", 'phpcs']
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
let g:ackprg = 'ag --nogroup --column'
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP .'
let g:ctrlp_regexp = 1
let g:ctrlp_lazy_update = 500
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:20'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --exclude-standard', 'find %s -type f']
let g:ctrlp_extensions = ['tag']
let g:SuperTabDefaultCompletionType = "<c-n>"
"let g:symfony_app_console_caller='ssh root@internations.dev ". ~/.profile; in_in; php"'
"let g:symfony_app_console_path= 'app-new/console'

" Setup UI
" --------
function! WriterMode()
    set linebreak
    set nonumber
    if has('gui_running')
        set guifont=Cousine:h18
        sleep 0 " needed for rendering
        set columns=80
        sleep 0 " needed for rendering
        set fuoptions=maxvert
        set fu
    endif
    nnoremap j gj
    nnoremap k gk
    vnoremap j gj
    vnoremap k gk
endfunction

function! CodingMode()
    set nolinebreak
    set number
    if has('gui_running')
        set guifont=Meslo\ LG\ S\ DZ:h12
    endif
    if &fu
        set columns=120
        sleep 0
        set nofu
    endif
    nunmap j
    nunmap k
    vunmap j
    vunmap k
endfunction

if has('gui_running')
    set vb " no bells; as macvim does not support visual bell
    set guioptions=aAce
    set background=light
    colorscheme spacedust
end

" Default mode
silent! call CodingMode()

" Temporary stuff to removed or moved to plugins
" ----------------------------------------------

" http://vim.wikia.com/wiki/Auto_highlight_current_word_when_idle
" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction
