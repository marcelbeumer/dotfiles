local M = {}

M.setup = function()
  require("conf.plugins").setup()
  require("conf.dev").setup()
  require("conf.quickfix").setup()
  require("conf.date").setup()
  require("conf.statusline").setup()
  require("conf.helm").setup()
  require("conf.settings").setup()
end

return M
