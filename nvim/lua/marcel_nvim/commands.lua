local M = {}

function M.setup_lsp_buffer(lsp_client, bufnr)
  vim.api.nvim_exec([[
    augroup format_on_save
      au!
      au BufWritePre *.ts,*.tsx lua vim.lsp.buf.formatting()
    augroup end
  ]], false)
end

function M.setup_global()
  vim.api.nvim_exec([[
    command W w
    command Todo e ~/Notes/content/todo.md
    command Bookmarks e ~/Notes/content/bookmarks.md
    command ReadingList e ~/Notes/content/reading_list.md
    command Commands e ~/.config/nvim/lua/marcel_nvim/commands.lua
    command Bindings e ~/.config/nvim/lua/marcel_nvim/bindings.lua
    command Settings e ~/.config/nvim/lua/marcel_nvim/settings.lua
  ]], false)
end

return M
