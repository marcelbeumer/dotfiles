local M =  {}

function M.setup()
  vim.api.nvim_exec([[
    let g:tokyonight_italic_comments = 0
    let g:tokyonight_italic_keywords = 0
  ]], false)
end

return M
