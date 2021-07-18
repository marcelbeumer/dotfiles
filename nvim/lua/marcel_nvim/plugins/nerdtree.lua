local M =  {}

function M.setup()
  vim.api.nvim_exec([[
    let NERDTreeShowHidden=1
    let NERDTreeWinSize=35
  ]], false)
end

return M
