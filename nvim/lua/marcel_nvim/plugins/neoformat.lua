local M =  {}

function M.setup()
  vim.api.nvim_exec([[
    let g:neoformat_enabled_typescript = ['denofmt']
    let g:neoformat_enabled_typescriptreact = ['denofmt']
  ]], false)
end

return M
