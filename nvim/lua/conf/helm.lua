local M = {}

function M.setup_buffer(bufnr)
  local path = vim.api.nvim_buf_get_name(bufnr)
  local is_chart_file = (
        string.match(path, "/templates/.*%.ya?ml")
        or string.match(path, "/templates/.*%.tpl")
        or string.match(path, "/templates/.*%.txt")
      )
      and 1
    or 0
  if is_chart_file == 1 then
    vim.diagnostic.disable(0)
    vim.api.nvim_buf_set_option(bufnr, "ft", "gotmpl")
  end
end

M.setup = function()
  vim.cmd([[
  autocmd BufReadPost * :lua require('conf.helm').setup_buffer(0)
]])
end

return M
