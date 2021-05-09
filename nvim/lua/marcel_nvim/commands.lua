local M = {}

function M.setup_lsp_buffer(lsp_client, bufnr)
end

function M.setup_global()
  vim.api.nvim_exec([[
    command W w
    " %bd all buffers, e# open previous, bd# delete previous (no name buffer)
    command BufferDeleteOthers %bd|e#|bd#

    command Todo e ~/Notes/content/todo.md
    command Scratch e ~/Notes/content/scratch.md
    command Bookmarks e ~/Notes/content/bookmarks.md
    command ReadingList e ~/Notes/content/reading_list.md
    command Commands e ~/.config/nvim/lua/marcel_nvim/commands.lua
    command Bindings e ~/.config/nvim/lua/marcel_nvim/bindings.lua
    command Settings e ~/.config/nvim/lua/marcel_nvim/settings.lua

    augroup fmt
      autocmd!
      autocmd BufWritePre *.ts,*.tsx silent! undojoin | Neoformat
    augroup END
  ]], false)
end

return M
