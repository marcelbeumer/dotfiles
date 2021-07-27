-- based on https://github.com/beauwilliams/statusline.lua/blob/e5d86eff45d1aef73f5f3ea8cb8209d0bedf60c9/lua/sections/_lsp.lua#L11
function _G.__nvim_marcel__get_lsp_status()
  local space = ' '
  local diagnostics = ''
  local e = vim.lsp.diagnostic.get_count(0, [[Error]])
  local w = vim.lsp.diagnostic.get_count(0, [[Warning]])
  local i= vim.lsp.diagnostic.get_count(0, [[Information]])
  local h= vim.lsp.diagnostic.get_count(0, [[Hint]])
  diagnostics = e~=0 and diagnostics..'E'..e..space or diagnostics
  diagnostics = w~=0 and diagnostics..'W'..w..space or diagnostics
  diagnostics = i~=0 and diagnostics..'I'..i..space or diagnostics
  diagnostics = h~=0 and diagnostics..'H'..h..space or diagnostics
  return diagnostics
end

-- based on https://unix.stackexchange.com/a/518439
vim.api.nvim_exec([[
  set statusline=%f\ %h%w%m%r%=%-8.(%{v:lua.__nvim_marcel__get_lsp_status()}%)%-14.(%l,%c%V%)\ %P
]], false)
