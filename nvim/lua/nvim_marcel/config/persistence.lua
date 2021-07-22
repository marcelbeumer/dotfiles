local configured = false
vim.api.nvim_exec([[
  au BufReadPre lua require("nvim_marcel.config.persistence").setup_persistance_once()
  command LoadSession lua require("nvim_marcel.config.persistence").load()<cr>
  command StopSession lua require("nvim_marcel.config.persistence").stop()<cr>
  command VimLeavePre NerdTreeClose
]], false)

local M = {}

function M.load()
  M.setup_persistance_once()
  require("persistence").load()
end

function M.stop()
  M.setup_persistance_once()
  require("persistence").stop()
end

function M.setup_persistance_once()
  if configured then return end
  configured = true
  require("persistence").setup({
    dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
  });
end

return M
