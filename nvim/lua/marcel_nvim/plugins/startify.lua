local M =  {}

function M.setup()
  vim.api.nvim_exec([[
    let g:startify_session_persistence = 1
  ]], false)
end

return M
