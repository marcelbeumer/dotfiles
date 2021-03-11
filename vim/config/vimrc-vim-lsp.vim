" -------------------------------
" Notes:
" 
" vim-lsp is a bit slow, you can feel typing stalling sometimes.
" maybe it's a good idea to always manually trigger autocomplete
" but then rather use <c-space> to toggle the auto mode, and
" always disable auto mode when going back to normal mode: 
" * typing... nothing happens
" * <c-space>... force autocomplete + set auto mode
" * typing auto completing automatically
" * <c-space> ...  auto complete off
" * or back to normal mode, also auto complete off
" Can implement this with a function and a insert mode keybinding
" and a autocommand on going back to normal mode
" -------------------------------

" -------------------------------
"  Plugins
" -------------------------------
call plug#begin('~/.vim/plugged-vimrc-vim-lsp')
" Color themes
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'romgrk/doom-one.vim'
" Others
Plug 'jremmen/vim-ripgrep'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'sbdchd/neoformat'
Plug 'liuchengxu/vista.vim'
call plug#end()

" -------------------------------
"  Vim settings
" -------------------------------
" Visuals
set termguicolors
set guioptions-=rL
set guicursor+=a:blinkon0
set guifont=Jetbrains\ Mono:h14
set laststatus=2
" set linespace=1
colorscheme dracula
" colorscheme gruvbox
" Editing
set clipboard=unnamed
set hidden 
set nobackup " coc.vim
set nowritebackup " coc.vim
" set noswapfile
set directory=$HOME/.vim/swp-vimrc-vim-lsp//
set shortmess+=c "
set updatetime=500
set signcolumn=yes
set autoindent
set smartindent
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set ignorecase 
set linebreak

" -------------------------------
"  General commands 
" -------------------------------
command Todo e ~/Notes/content/todo.md

" -------------------------------
"  General mappings
" -------------------------------
nnoremap <silent><leader>w :w<CR>
nnoremap <silent><leader>p :FGFiles<CR>
nnoremap <silent><leader>b :FBuffers<CR>
nnoremap <silent><leader>; :NERDTreeToggle<CR>
nnoremap <silent><leader>' :NERDTreeFind<CR>
" inoremap <C-Space> <C-x><C-o>
imap <c-space> <Plug>(asyncomplete_force_refresh)

" -------------------------------
"  Auto commands 
" -------------------------------
augroup fmt
  autocmd!
  autocmd BufWritePre * silent! undojoin | Neoformat
augroup END

" -------------------------------
"  Plugin settings 
" -------------------------------
" Asyncomplete
let g:asyncomplete_auto_popup = 0
let g:asyncomplete_popup_delay = 0
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
" make cr a newline always
" inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() . "\<cr>" : "\<cr>"
" allow modifying the completeopt variable, or it will
" be overridden all the time
let g:asyncomplete_auto_completeopt = 0
set completeopt=menuone,noinsert,noselect,preview
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
" Neoformat
let g:neoformat_enabled_typescript = ['denofmt']
let g:neoformat_enabled_typescriptreact = ['denofmt']
" FZF
set rtp+=~/.fzf
let g:fzf_command_prefix = 'F'
" vim-lsp
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_document_code_action_signs_enabled = 0
" let g:lsp_diagnostics_signs_delay = 50
" let g:lsp_diagnostics_virtual_text_delay = 50
" let g:lsp_diagnostics_highlights_delay = 50
" let g:lsp_format_sync_timeout = 1000
let g:lsp_diagnostics_highlights_enabled = 0
" let g:lsp_signature_help_enabled = 0
" Vista
let g:vista_default_executive = 'vim_lsp'

" -------------------------------
"  LSP specific 
" -------------------------------
function! s:on_lsp_buffer_enabled() abort
  " -------------------------------
  "  LSP vim settings 
  " -------------------------------
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

  " -------------------------------
  "  LSP mappings
  " -------------------------------
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gs <plug>(lsp-document-symbol-search)
  nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> gt <plug>(lsp-type-definition)
  nmap <buffer> <leader>rn <plug>(lsp-rename)
  nmap <buffer> [g <plug>(lsp-previous-diagnostic)
  nmap <buffer> ]g <plug>(lsp-next-diagnostic)
  nmap <buffer> K <plug>(lsp-hover)
  inoremap <buffer> <expr><c-f> lsp#scroll(+4)
  inoremap <buffer> <expr><c-d> lsp#scroll(-4)
  " Mine
  nnoremap <buffer> <leader>ac :LspCodeAction<CR>
  nnoremap <buffer> <leader>df :LspDocumentDiagnostics<CR>
  nnoremap <buffer> <leader>da :LspDocumentDiagnostics --buffers=*<CR>

  " -------------------------------
  "  LSP commands
  " -------------------------------
  command-buffer OrganizeImports call execute('LspCodeActionSync source.organizeImports')

  " -------------------------------
  "  LSP auto commands
  " -------------------------------
  function! s:set_status_line()
    let b:marcel_status_line_counts = lsp#get_buffer_diagnostics_counts()
    setlocal statusline=%f
    setlocal statusline+=\ %=lsp
    setlocal statusline+=\ %{b:marcel_status_line_counts.hint}
    setlocal statusline+=\|%{b:marcel_status_line_counts.warning}
    setlocal statusline+=\|%{b:marcel_status_line_counts.error}
    setlocal statusline+=\ 
  endfunction

  augroup lsp_status_line
    au!
    autocmd User lsp_diagnostics_updated call s:set_status_line()

  augroup END
  
  call s:set_status_line()
endfunction


augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
  " autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
augroup END

