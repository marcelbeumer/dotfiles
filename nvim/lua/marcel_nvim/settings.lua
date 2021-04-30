local M = {}

function M.setup_lsp_buffer(lsp_client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  if lsp_client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

function M.setup_global()
  vim.api.nvim_exec([[
    set termguicolors
    set guioptions-=rL
    set guicursor+=a:blinkon0
    set guifont=Jetbrains\ Mono:h14
    set laststatus=2
    " set linespace=1
    colorscheme dracula
    " colorscheme tokyonight

    " Editing
    set clipboard=unnamed
    set hidden 
    set shortmess+=c 
    set signcolumn=yes
    set updatetime=1000 " for CursorHold event
    set mouse=nv " nice for window sizing

    " set autoindent
    set expandtab
    set shiftwidth=2
    set softtabstop=2
    set tabstop=2
    set smartindent

    set ignorecase 
    set joinspaces
    set linebreak
    set completeopt=menuone,noselect
  ]], false)
end

return M
