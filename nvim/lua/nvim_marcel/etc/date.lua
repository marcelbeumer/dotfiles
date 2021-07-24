vim.api.nvim_exec([[
  function! DateStrPretty() range
    return system('date "+%Y-%m-%d %H:%M:%S" | tr -d "\n"')
  endfunction

  function! DateStrFs() range
    return system('date "+%Y-%m-%d-%H%M-%S" | tr -d "\n"')
  endfunction
]], false)