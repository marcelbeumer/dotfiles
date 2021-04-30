local M =  {}

function M.setup()
  vim.api.nvim_exec([[
    let g:nvim_tree_show_icons = { 'git': 0, 'folders': 0, 'files': 0 }
  ]], false)
end

return M
