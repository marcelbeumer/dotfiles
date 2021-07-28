require('trouble').setup({
  icons = false,
  fold_open = "v",
  fold_closed = ">",
  indent_lines = false,
  signs = {
    error = "error",
    warning = "warn",
    hint = "hint",
    information = "info"
  },
  use_lsp_diagnostic_signs = false
})

vim.cmd([[
  " lsp-trouble global bindings because also needs to work in trouble buffer itself
  nnoremap <leader>xx <cmd>TroubleToggle<cr>
  nnoremap <leader>xw <cmd>TroubleToggle lsp_workspace_diagnostics<cr>
  nnoremap <leader>xd <cmd>TroubleToggle lsp_document_diagnostics<cr>
  nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
  nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
  nnoremap gR <cmd>TroubleToggle lsp_references<cr>
]])
