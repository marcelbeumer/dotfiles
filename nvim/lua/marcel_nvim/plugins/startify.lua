local M =  {}

function M.setup()
  vim.api.nvim_exec([[
    let g:startify_session_persistence = 1
    let g:startify_session_before_save = [ 'silent! tabdo NERDTreeClose' ]
    let g:startify_lists = [ { 'type': 'sessions',  'header': ['   Sessions'] }, { 'type': 'dir', 'header': ['   MRU '. getcwd()] }, { 'type': 'files', 'header': ['   MRU'] } ]
    let g:startify_custom_indices = map(range(1,100), 'string(v:val)')
  ]], false)
end

return M
