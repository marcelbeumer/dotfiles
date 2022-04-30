local M = {}

function M.setup()
  function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, { ... })
    print(unpack(objects))
    return ...
  end
end

return M
