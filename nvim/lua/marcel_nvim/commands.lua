local M = {}

function M.setup_lsp_buffer()
  vim.api.nvim_exec([[
    augroup lsp_format_on_save
      autocmd! * <buffer>
      autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
    augroup END
  ]], true)
end

function M.setup_global()
  vim.api.nvim_exec([[
    " https://stackoverflow.com/questions/8450919/how-can-i-delete-all-hidden-buffers
    function! DeleteHiddenBuffers()
      let tpbl=[]
      let closed = 0
      call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
      for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        if getbufvar(buf, '&mod') == 0
          silent execute 'bwipeout' buf
          let closed += 1
        endif
      endfor
      echo "Closed ".closed." hidden buffers"
    endfunction

    command W w
    " %bd all buffers, e# open previous, bd# delete previous (no name buffer)
    command BufferDeleteOthers %bd|e#|bd#
    command BufferDeleteHidden call DeleteHiddenBuffers()

    command Todo e ~/Notes/content/todo.md
    command Scratch e ~/Notes/content/scratch.md
    command Bookmarks e ~/Notes/content/bookmarks.md
    command ReadingList e ~/Notes/content/reading_list.md
    command Commands e ~/.config/nvim/lua/marcel_nvim/commands.lua
    command Bindings e ~/.config/nvim/lua/marcel_nvim/bindings.lua
    command Settings e ~/.config/nvim/lua/marcel_nvim/settings.lua
  ]], false)
end

return M
