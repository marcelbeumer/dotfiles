local M = {}

function M.setup_buffer(bufnr)
  local path = vim.api.nvim_buf_get_name(bufnr)
  local is_chart_yaml = string.match(path, "/chart/.*%.ya?ml") and 1 or 0
  local is_chart_tpl = string.match(path, "/chart/.*%.tpl") and 1 or 0
  if is_chart_tpl == 1 or is_chart_yaml == 1 then
    vim.diagnostic.disable()
    vim.api.nvim_buf_set_option(bufnr, "ft", "text")
  end
end

vim.cmd([[
  autocmd BufReadPost * :lua require('nvim_marcel.etc.helm').setup_buffer(0)
]])

return M
