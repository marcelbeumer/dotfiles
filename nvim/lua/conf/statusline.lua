local M = {}

M.statusline = function()
  -- based on https://github.com/beauwilliams/statusline.lua/blob/e5d86eff45d1aef73f5f3ea8cb8209d0bedf60c9/lua/sections/_lsp.lua#L11
  local space = " "
  local diagnostics = ""
  local e = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local w = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  local h = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
  local i = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  diagnostics = e ~= 0 and diagnostics .. "E" .. e .. space or diagnostics
  diagnostics = w ~= 0 and diagnostics .. "W" .. w .. space or diagnostics
  diagnostics = i ~= 0 and diagnostics .. "I" .. i .. space or diagnostics
  diagnostics = h ~= 0 and diagnostics .. "H" .. h .. space or diagnostics
  return diagnostics
end

M.setup = function()
  -- based on https://unix.stackexchange.com/a/518439
  vim.cmd([[
  set statusline=%f\ %h%w%m%r%=%-8.(%{v:lua.require'conf.statusline'.statusline()}%)%-14.(%l,%c%V%)\ %P
]])
end

return M
