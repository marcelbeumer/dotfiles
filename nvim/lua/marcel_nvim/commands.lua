local M = {}

function M.setup_global()
  vim.api.nvim_exec([[
    command Todo e ~/Notes/content/todo.md
    command Bookmarks e ~/Notes/content/bookmarks.md
    command ReadingList e ~/Notes/content/reading_list.md
  ]], false)
end

return M
