local M = {}

function M.setup()
  local nvim_lsp = require('lspconfig')
  local on_attach = function(lsp_client, bufnr)
    require('marcel_nvim.bindings').setup_lsp_buffer(lsp_client, bufnr)
    require('marcel_nvim.settings').setup_lsp_buffer(lsp_client, bufnr)
  end
  local servers = { "tsserver" }
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup { on_attach = on_attach }
  end
end

return M
