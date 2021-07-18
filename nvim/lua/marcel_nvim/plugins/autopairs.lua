local M =  {}

function M.setup()
  require('nvim-autopairs').setup({
    disable_filetype = { "TelescopePrompt" , "vim" },
  })
end

return M
