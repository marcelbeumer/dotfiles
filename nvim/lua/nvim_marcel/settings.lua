vim.api.nvim_exec([[
  " Visuals
  set termguicolors
  set guioptions-=rL
  set guicursor+=a:blinkon0
  set guifont=Jetbrains\ Mono:h14
  set laststatus=2
  set signcolumn=yes
  " set background=light
  colorscheme tokyonight

  " Backup, swap
  " set nobackup
  " set nowritebackup
  set noswapfile

  " Editing
  set clipboard=unnamed
  set hidden 
  set shortmess+=c 
  set updatetime=800 " for CursorHold event
  set mouse=nv " nice for window sizing
  set expandtab
  set shiftwidth=2
  set softtabstop=2
  set tabstop=2
  set autoindent
  set smartindent
  set ignorecase 
  set joinspaces
  set linebreak

  " Commands
  command W w
  " %bd all buffers, e# open previous, bd# delete previous (no name buffer)
  command BD %bd|e#|bd#
  command FilePath let @*=expand("%")
  command FilePathAbs let @*=expand("%:p")
  command FilePathHead let @*=expand("%:h")
  command FilePathTail let @*=expand("%:t")
  command Todo e ~/Notes/content/todo.md
  command Scratch e ~/Notes/content/scratch.md
  command MyBookmarks e ~/Notes/content/bookmarks.md
  command ReadingList e ~/Notes/content/reading_list.md
  command Inbox e ~/Notes/content/inbox.md

  au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=200, on_visual=true}

  " Bindings
  nnoremap <silent>]q :cnext<CR>
  nnoremap <silent>[q :cprev<CR>
  nnoremap <silent>]Q :lnext<CR>
  nnoremap <silent>[Q :lprev<CR>
  nnoremap <silent>]t :tabnext<CR>
  nnoremap <silent>[t :tabprev<CR>
  nnoremap <silent><C-L> :tabnext<CR>
  nnoremap <silent><C-H> :tabprev<CR>
  nnoremap <silent><C-s> :w<CR>
  nnoremap <silent><C-w>N :vnew<CR>
  nnoremap <silent><leader>s :w<CR>
  nnoremap <silent><leader>tn :tabnew<CR>
  nnoremap <silent><leader>tc :tabclose<CR>
]], false)
