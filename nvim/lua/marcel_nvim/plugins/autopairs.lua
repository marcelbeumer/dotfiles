local M =  {}

function M.setup()
  require('nvim-autopairs').setup({
    disable_filetype = { "TelescopePrompt" , "vim", "markdown" },
  })
end

return M
