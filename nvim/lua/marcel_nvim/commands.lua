local M = {}

function M.setup_lsp_buffer()
  vim.api.nvim_exec([[
    augroup lsp_format_on_save
      autocmd! * <buffer>
      " let fts = ['typescript', 'typescriptreact']
      " if index(fts, &filetype) != -1
      "   autocmd BufWritePre <buffer> TSLspOrganizeSync
      " endif
      autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
    augroup END
  ]], true)
end

local function split_str(v)
  local args = {}
  for s in string.gmatch(v, "%S+") do
    table.insert(args, s)
  end
  return args
end

function _G.__marcel_nvim__telescope_live_grep(v)
  local opts = {}
  if #v > 0 then
   opts.search_dirs = split_str(v)
  end
  require'telescope.builtin'.live_grep(opts)
end

function _G.__marcel_nvim__telescope_find_files(v)
  local opts = {}
  if #v > 0 then
   opts.search_dirs = split_str(v)
  end
  require'telescope.builtin'.find_files(opts)
end

function M.setup_global()
  vim.api.nvim_exec([[
    command W w
    " %bd all buffers, e# open previous, bd# delete previous (no name buffer)
    command TSIM TSLspOrganize
    command BDForce %bd!|e#|bd#
    command BD %bd|e#|bd#
    command S Startify
    command FilePath let @*=expand("%")
    command FilePathAbs let @*=expand("%:p")
    command FilePathHead let @*=expand("%:h")
    command FilePathTail let @*=expand("%:t")
    command Todo e ~/Notes/content/todo.md
    command Scratch e ~/Notes/content/scratch.md
    command MyBookmarks e ~/Notes/content/bookmarks.md
    command ReadingList e ~/Notes/content/reading_list.md
    command Inbox e ~/Notes/content/inbox.md
    command Commands e ~/.config/nvim/lua/marcel_nvim/commands.lua
    command Bindings e ~/.config/nvim/lua/marcel_nvim/bindings.lua
    command Settings e ~/.config/nvim/lua/marcel_nvim/settings.lua
    command! -nargs=* -complete=file TelescopeLiveGrep lua __marcel_nvim__telescope_live_grep(<q-args>)
    command! -nargs=* -complete=file TelescopeFindFiles lua __marcel_nvim__telescope_find_files(<q-args>)

    au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=200, on_visual=true}

    " https://vi.stackexchange.com/questions/21254/visual-delete-items-from-quickfix-list
    " using range-aware function
    function! QFdelete(bufnr) range
        " get current qflist
        let l:qfl = getqflist()
        " no need for filter() and such; just drop the items in range
        call remove(l:qfl, a:firstline - 1, a:lastline - 1)
        " replace items in the current list, do not make a new copy of it;
        " this also preserves the list title
        call setqflist([], 'r', {'items': l:qfl})
        " restore current line
        call setpos('.', [a:bufnr, a:firstline, 1, 0])
    endfunction

    " using buffer-local mappings
    " note: still have to check &bt value to filter out `:e quickfix` and such
    augroup QFList | au!
        autocmd BufWinEnter quickfix if &bt ==# 'quickfix'
        autocmd BufWinEnter quickfix    nnoremap <silent><buffer>dd :call QFdelete(bufnr())<CR>
        autocmd BufWinEnter quickfix    vnoremap <silent><buffer>d  :call QFdelete(bufnr())<CR>
        autocmd BufWinEnter quickfix endif
    augroup end
  ]], false)
end

return M
