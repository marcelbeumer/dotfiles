local M =  {}

function M.setup()
  vim.api.nvim_exec([[
    let g:startify_session_persistence = 1
    let g:startify_session_before_save = [ 'silent! tabdo NERDTreeClose' ]
  ]], false)
end

return M
