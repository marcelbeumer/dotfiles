local M =  {}

function M.setup()
  require('auto-session').setup({
    pre_save_cmds = {"tabdo NERDTreeClose"}
  })
end

return M
