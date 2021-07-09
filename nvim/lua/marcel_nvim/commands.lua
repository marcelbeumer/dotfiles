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
    command Bookmarks e ~/Notes/content/bookmarks.md
    command ReadingList e ~/Notes/content/reading_list.md
    command Commands e ~/.config/nvim/lua/marcel_nvim/commands.lua
    command Bindings e ~/.config/nvim/lua/marcel_nvim/bindings.lua
    command Settings e ~/.config/nvim/lua/marcel_nvim/settings.lua
    command! -nargs=* -complete=file TelescopeLiveGrep lua __marcel_nvim__telescope_live_grep(<q-args>)
    command! -nargs=* -complete=file TelescopeFindFiles lua __marcel_nvim__telescope_find_files(<q-args>)
  ]], false)
end

return M
