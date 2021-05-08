local M =  {}

function M.setup()
  vim.api.nvim_exec([[
    let g:startify_session_persistence = 1
    let g:startify_session_before_save = [ 'silent! tabdo NERDTreeClose' ]
    let g:startify_lists = [ { 'type': 'sessions',  'header': ['   Sessions'] }, { 'type': 'files', 'header': ['   MRU'] }, { 'type': 'dir', 'header': ['   MRU '. getcwd()] }]
  ]], false)
end

return M
