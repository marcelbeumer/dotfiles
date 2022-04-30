local M = {}

M.setup = function()
  vim.cmd([[
    " WIP: idea is to add something to the quickfix list with for example <leader>qa and have a <leader>qq to toggle list
    function! QFadd() range
        " get current qflist
        let l:qfl = getqflist()
        let newItems = [{'filename' : 'a.txt', 'lnum' : 10, 'text' : "Apple"}]
        call setqflist([], 'a', {'items': newItems})
    endfunction

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
  ]])
end

return M
