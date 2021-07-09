local M =  {}

local plugin_enabled = false

function M.setup_lsp_buffer(lsp_client, bufnr)
  if plugin_enabled then
    require'completion'.on_attach(lsp_client, bufnr)
  end
end

function M.setup()
  plugin_enabled = true
  vim.api.nvim_exec([[
    let g:startify_session_persistence = 1
  ]], false)
end

return M
