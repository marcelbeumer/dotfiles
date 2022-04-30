local lspconfig = require("lspconfig")

local flags_common = { debounce_text_changes = 300 }

local on_attach_common = function(lsp_client, bufnr)
  -- Setup omnicomplete (nice to have on the side)
  vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

  local function bufmap(mode, lhs, rhs)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true })
  end

  -- Built-in lsp
  bufmap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>")
  bufmap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")
  bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  bufmap("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
  bufmap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>")
  bufmap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  bufmap("i", "<C-y>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  bufmap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
  bufmap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
  bufmap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
  bufmap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
  bufmap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  bufmap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
  bufmap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
  bufmap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
  bufmap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>")
  -- Goto-preview
  bufmap("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>")
  bufmap("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
  bufmap("n", "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>")

  if lsp_client.resolved_capabilities.document_formatting then
    bufmap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>")

    vim.cmd([[
      augroup lsp_buffer_formatting
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
      augroup END
    ]])
  end

  if lsp_client.resolved_capabilities.document_range_formatting then
    bufmap("v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>")
  end

  if lsp_client.resolved_capabilities.document_highlight then
    vim.cmd([[
      augroup lsp_buffer_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]])
  end
end

local function setup_null_ls()
  local null_ls = require("null-ls")
  local sources = {
    null_ls.builtins.formatting.stylua,
    -- null_ls.builtins.formatting.gofmt,
    -- null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.golines,
    null_ls.builtins.diagnostics.golangci_lint,
    null_ls.builtins.formatting.black,
    -- null_ls.builtins.diagnostics.pylint,
    null_ls.builtins.formatting.prettierd,
    -- null_ls.builtins.diagnostics.eslint_d,
  }

  null_ls.setup({
    debounce = 150,
    sources = sources,
    on_attach = function(lsp_client, bufnr)
      on_attach_common(lsp_client, bufnr)
    end,
  })
end

local function setup_volar()
  lspconfig.volar.setup({
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
    capabilities = require("conf.plugins.cmp").get_lsp_capabilities(),
    flags = flags_common,
    on_attach = function(lsp_client, bufnr)
      lsp_client.resolved_capabilities.document_formatting = false
      lsp_client.resolved_capabilities.document_range_formatting = false
      on_attach_common(lsp_client, bufnr)
    end,
  })
end

local function setup_tsserver()
  lspconfig.tsserver.setup({
    capabilities = require("conf.plugins.cmp").get_lsp_capabilities(),
    flags = flags_common,
    init_options = {
      -- preferences = {
      --   importModuleSpecifierEnding = "js",
      -- },
    },
    on_attach = function(lsp_client, bufnr)
      lsp_client.resolved_capabilities.document_formatting = false
      lsp_client.resolved_capabilities.document_range_formatting = false
      local lsp_ts_utils = require("nvim-lsp-ts-utils")
      lsp_ts_utils.setup({
        eslint_enable_code_actions = false,
        update_imports_on_move = true,
        require_confirmation_on_move = true,
      })
      lsp_ts_utils.setup_client(lsp_client)
      vim.cmd([[command! -buffer OrganizeImports TSLspOrganize]])
      on_attach_common(lsp_client, bufnr)
      -- vim.cmd("TSLspOrganizeSync")
      -- vim.lsp.buf.formatting_sync()
      -- vim.cmd("up")
      -- vim.defer_fn(function()
      --   vim.cmd("next")
      -- end, 100)
    end,
  })
end

local function setup_lua()
  local luadev = require("lua-dev").setup({
    lspconfig = {
      cmd = { "lua-language-server" },
      on_attach = on_attach_common,
    },
  })
  lspconfig.sumneko_lua.setup(luadev)
end

local function setup_gopls()
  lspconfig.gopls.setup({
    on_attach = function(lsp_client, bufnr)
      lsp_client.resolved_capabilities.document_formatting = false
      lsp_client.resolved_capabilities.document_range_formatting = false
      on_attach_common(lsp_client, bufnr)
    end,
  })
end

local function setup_jedi_language_server()
  lspconfig.jedi_language_server.setup({
    on_attach = function(lsp_client, bufnr)
      on_attach_common(lsp_client, bufnr)
    end,
  })
end

local function setup_yamlls()
  lspconfig.yamlls.setup({
    on_attach = on_attach_common,
    settings = {
      yaml = {
        schemas = {
          -- ["https://json.schemastore.org/chart.json"] = "/chart/*",
          kubernetes = {
            "k8s/**/*.yml",
            "k8s/**/*.yaml",
          },
        },
      },
    },
  })
end

local diagnostic_noise_level = 2

local function setup_diagnostics()
  vim.diagnostic.config({
    signs = diagnostic_noise_level >= 1,
    underline = diagnostic_noise_level >= 2,
    virtual_text = diagnostic_noise_level >= 3,
    update_in_insert = true,
    severity_sort = true,
  })
end

local M = {}

function M.command_diagnostic_noise_level(level)
  if level == nil then
    print(diagnostic_noise_level)
    return
  end
  diagnostic_noise_level = tonumber(level)
  setup_diagnostics()
  vim.diagnostic.hide()
  vim.diagnostic.show()
end

function M.setup()
  require("goto-preview").setup({})
  -- vim.lsp.set_log_level("debug")
  setup_null_ls()
  setup_tsserver()
  -- setup_volar()
  setup_gopls()
  setup_lua()
  setup_diagnostics()
  setup_jedi_language_server()
  setup_yamlls()

  vim.cmd(
    [[command! -nargs=? DiagnosticNoiseLevel ]]
      .. [[lua require("conf.plugins.lsp").command_diagnostic_noise_level(<args>)<CR>]]
  )
end

return M
