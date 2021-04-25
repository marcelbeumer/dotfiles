local M =  {}

function M.setup()
  vim.api.nvim_exec([[
    let g:vsnip_filetypes = {}
    let g:vsnip_filetypes.javascriptreact = ['javascript']
    let g:vsnip_filetypes.typescriptreact = ['typescript']
    let g:vsnip_snippet_dir = expand('~/.config/nvim/vsnip')
  ]], false)
end

return M
