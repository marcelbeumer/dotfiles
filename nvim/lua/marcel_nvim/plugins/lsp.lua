local M = {}

function M.setup()
  local nvim_lsp = require('lspconfig')

  local on_attach_common = function(lsp_client, bufnr)
    require('marcel_nvim.bindings').setup_lsp_buffer(lsp_client, bufnr)
    require('marcel_nvim.settings').setup_lsp_buffer(lsp_client, bufnr)
    require('marcel_nvim.commands').setup_lsp_buffer(lsp_client, bufnr)
  end

  nvim_lsp.tsserver.setup { 
    on_attach = function(lsp_client, bufnr)
      lsp_client.resolved_capabilities.document_formatting = false
      lsp_client.resolved_capabilities.document_range_formatting = false
      on_attach_common(lsp_client, bufnr)
    end
  }

  local deno_fmt = {formatCommand = "deno fmt -", formatStdin = true}
  local lua_fmt = {formatCommand = "lua-format -i", formatStdin = true}

  nvim_lsp.efm.setup {
    on_attach = on_attach_common,
    init_options = {documentFormatting = true},
    settings = {
      rootMarkers = {".git/"},
      languages = {
        lua = { lua_fmt },
        typescript = { deno_fmt },
        typescriptreact = { deno_fmt },
      }
    }
  }
end

return M
