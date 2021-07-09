function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
    return ...
end

local M = {}

function M.setup()
end

return M
