set nocompatible
filetype off

runtime macros/matchit.vim
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" Themes
" ------
Bundle 'altercation/vim-colors-solarized'
Bundle 'flazz/vim-colorschemes'
Bundle 'marcelbeumer/spacedust.vim'
Bundle 'mrtazz/molokai.vim'

" Language support
" ----------------
Bundle 'arnaud-lb/vim-php-namespace'
Bundle 'beyondwords/vim-twig'
Bundle 'django.vim'
Bundle 'groenewege/vim-less'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'kchmck/vim-coffee-script'
Bundle 'marcelbeumer/javascript-syntax.vim'
Bundle 'nono/vim-handlebars'
Bundle 'othree/coffee-check.vim'
Bundle 'shawncplus/phpcomplete.vim'
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
Bundle 'tpope/vim-unimpaired'

" Navigation, search, GUI
" -----------------------
Bundle 'ZoomWin'
Bundle 'ack.vim'
Bundle 'ervandew/supertab'
Bundle 'kien/ctrlp.vim'
Bundle 'marcelbeumer/color-color.vim'
Bundle 'nelstrom/vim-qargs'
Bundle 'scrooloose/nerdtree'
Bundle 'sjl/gundo.vim'

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
set autoindent
set clipboard=unnamed
set expandtab
set foldlevel=100
set foldmethod=indent
set hidden
set incsearch
set ignorecase
set nobackup
set noswapfile
set numberwidth=5
set ruler
set scrolloff=10
set shiftround
set shiftwidth=4
set shortmess=atI
set softtabstop=4
set suffixesadd+=.js
set suffixesadd+=.php
set tabstop=4
set timeoutlen=500 " timeout of leader key
set undodir=~/.vimundo
set undofile
set wildignore+=*.o,*.obj,.git,.hg,*.pyc
set wildmenu

" Key mappings
" ------------

" Window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Omnicomplet with C-Space
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>

" Plugin triggers
map  <leader>c :CoffeeCompile<CR>
map  <leader>g :call EditIncludeOnLine()<CR>
nmap <Leader><leader>c :ColorColorToggle<cr>
nmap <leader>: :NERDTreeMirror<cr>
nmap <leader>; :NERDTreeToggle<cr>
nmap <leader>b :CtrlPBuffer<cr>
nmap <leader>t :CtrlPTag<cr>
vmap <leader>c <esc>:'<,'>:CoffeeCompile<CR>

" Convert newlines and retab
nmap <Leader>r :%s/\r/\r/g<cr>gg<cr>:retab<cr>

" Removed whitespace in empty lines, and remove trailing whitespace
nmap <Leader>w :%s/^\s\+$//ge<cr>:%s/\(\S\)\s\+$/\1/ge<cr>

" Easy folding on search expr
nmap <silent><leader>z :set foldexpr=getline(v:lnum)!~@/ foldlevel=0 foldcolumn=0 foldmethod=expr<CR>

" Filetype settings
" -----------------

"  TODO
"  - evaluate includeexpr, replacing v:fname with something else
"  - come up with practical name for this thing instead of EditIncludeOnLine
"  - move command (create it), function, setup and standard parsers and
"  - remove setup function if includeexpr evel works, and simpy set the
"  b:something or the g:something
"  - Also check for g:..parser
"  resolves, as well as default filetype handlers into a plugin, so
"  right now the only thing that needs to be in this the setlocal stuff and
"  the twig stuff

function! EditIncludeOnLine()
    let line = getline('.')
    if exists("b:edit_include_line_parser")
        let GrabFn = function(b:edit_include_line_parser)
        let line = call(GrabFn, [line])
    endif
    let path = line
    if exists("b:edit_include_path_resolver")
        let ResolveFn = function(b:edit_include_path_resolver)
        let path = call(ResolveFn, [line])
    endif
    let path = findfile(path)
    exec 'e ' . path
endfunction

function! EditIncludeBufferSetup(pathResolver, lineParser)
    let lineParser = 'DefaultIncludeLineParser'
    if strlen(a:lineParser) > 0
        let lineParser = a:lineParser
    endif
    exec 'let b:edit_include_line_parser=''' . lineParser . ''''
    if strlen(a:pathResolver) > 0
        exec 'let b:edit_include_path_resolver=''' . a:pathResolver . ''''
        exec 'setlocal includeexpr=' . a:pathResolver . '(v:fname)'
    endif
endfunction

function! DefaultIncludeLineParser(line)
    return substitute(a:line, '.\{-}[''"]\(.\{-}\)[''"].*', '\1', 'g')
endfunction

function! PHPEditIncludeLineParser(line)
    let line = substitute(a:line, '.\{-}use\s\+\(\S*\);.*', '\1', 'g')
    return DefaultIncludeLineParser(line)
endfunction

function! PHPEditIncludePathResolver(fname)
    let fname = a:fname
    if stridx(fname, ':') != -1
        let fname = TwigEditIncludePathResolver(fname)
    endif
    return substitute(fname, '\', '/', 'g')
endfunction

function! TwigEditIncludePathResolver(fname)
    let fname = a:fname
    let fname = substitute(fname, ':', '/', 'g')
    let fname = substitute(fname, '^InterNations\(.\{-}\)Bundle', '\1Bundle/Resources/views/', 'g')
    return fname
endfunction

function! PHPSettings()
    call EditIncludeBufferSetup('PHPEditIncludePathResolver', 'PHPEditIncludeLineParser')
    setlocal suffixesadd+=.php
    setlocal path+=app-new/src/**
    setlocal path+=vendor/sensio/**
    setlocal path+=vendor/twig/**
    setlocal path+=vendor/symfony/**
    setlocal path+=vendor/doctrine/**
    setlocal tags=tags.php,tags.vendor.php
endfunction

" Ideally
" function! PHPSettings()
"     let b:edit_include_line_parser='PHPIncludeLineParser'
"     setlocal includeexpr=PHPIncludeExpr(v:fname)
"     setlocal suffixesadd+=.php
"     setlocal path+=app-new/src/**
"     setlocal path+=vendor/sensio/**
"     setlocal path+=vendor/twig/**
"     setlocal path+=vendor/symfony/**
"     setlocal path+=vendor/doctrine/**
"  endfunction

function! HTMLTwigSettings()
    call EditIncludeBufferSetup('TwigEditIncludePathResolver', '')
    setlocal path+=app-new/src/**
endfunction

function! XMLSettings()
    call EditIncludeBufferSetup('PHPEditIncludePathResolver', '')
    setlocal path+=app-new/src/**
endfunction

function! JavaScriptSettings()
    call EditIncludeBufferSetup('', '')
    setlocal suffixesadd+=.js
    setlocal path+=app-new/src/**
    setlocal tags=tags.js,tags.vendor.js
endfunction

autocmd FileType php call PHPSettings()
autocmd FileType javascript call JavaScriptSettings()
autocmd FileType html.twig call HTMLTwigSettings()
autocmd FileType xml call XMLSettings()

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
command -range=% BeautifyJS <line1>,<line2>!js-beautify --indent-size=4 -
command -range=% UglifyJS <line1>,<line2>!uglifyjs
command -range=% Xmltidy <line1>,<line2>!tidy -xml -indent -utf8 -q --indent-spaces 4
command ClearUndo silent !rm ~/.vimundo/*
command CodingMode silent! call CodingMode()
command IN e build.xml
command INJournal Note IN - Journal
command INTech Note IN - Tech
command JSHint !jshint % --show-non-errors
command JournalDate silent r !date +\%a\ \%d\ \%B\ \%Y\ \%Hh\%M
command ConvertJournalDate silent %s/\(\d\{2\}\):\(\d\{2\}\)/\1h\2/g
command Marked silent !/Applications/Marked.app/Contents/MacOS/Marked "%" &
command Nf NERDTreeFind
command PHPExpandClass call PhpExpandClass()
command Phpcs !vendor/bin/phpcs % --standard=ruleset.xml
command Rc e ~/.vimrc
command Rr silent! so $MYVIMRC
command SudoWrite w !sudo tee % > /dev/null
command WriterMode silent! call WriterMode()

" Plugin config
" -------------
"let g:symfony_app_console_caller='ssh root@internations.dev ". ~/.profile; in_in; php"'
"let g:symfony_app_console_path= 'app-new/console'
let NERDTreeBookmarksFile = $HOME . '/.vim_nerdtree_bookmarks'
let NERDTreeIgnore=['\.pyc$', '\~$']
let NERDTreeShowBookmarks=1
let NERDTreeWinSize=50
let coffee_make_options = '-o /tmp/'
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:ackprg = 'ag --nogroup --column'
let g:ctrlp_cmd = 'CtrlP .'
let g:ctrlp_extensions = ['tag']
let g:ctrlp_lazy_update = 500
let g:ctrlp_map = '<leader>p'
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:20'
let g:ctrlp_regexp = 1
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --exclude-standard', 'find %s -type f']
let g:notes_directories = ['~/Documents/Notes']
let g:notes_suffix = '.txt'
let g:notes_title_sync = 'change_title'
let g:syntastic_auto_loc_list=1
let g:syntastic_enable_signs=1
let g:syntastic_html_checkers=[]
let g:syntastic_php_checkers=['php'] ", 'phpcs']
let g:syntastic_scss_checkers=[]
let g:yankring_history_file = '.yankring_history'

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
    set guioptions=aAc "add 'e' for native tabs
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
