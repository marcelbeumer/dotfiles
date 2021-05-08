local M =  {}

function M.setup()
  vim.api.nvim_exec([[ set termguicolors ]], false)
  -- Disable for all filetypes, use commands
  -- :ColorizerAttachToBuffer and :ColorizerDetachFromBuffer
  require 'colorizer'.setup({}, { css = true; css_fn = true; })
end

return M
