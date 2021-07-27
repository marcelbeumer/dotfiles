local lspconfig = require('lspconfig')

local flags_common = { debounce_text_changes = 300 };

local on_attach_common = function(lsp_client, bufnr)
  require("lsp_signature").on_attach({
    bind = true,
    floating_window = true, -- false for virtual_text
    hint_enable = false,
    handler_opts = {
      border = "none"
    }
  })

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  -- built-in lsp
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if lsp_client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    vim.api.nvim_exec([[
      augroup lsp_buffer_formatting
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
      augroup END
    ]], false)
  end
  if lsp_client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  if lsp_client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      augroup lsp_buffer_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

local function setup_efm()
  local deno_fmt = {formatCommand = "deno fmt -", formatStdin = true}
  local lua_fmt = {formatCommand = "lua-format -i", formatStdin = true}

  lspconfig.efm.setup {
    on_attach = on_attach_common,
    init_options = {documentFormatting = true},
    filetypes = {
      "typescript", 
      "typescriptreact", 
      "javascript", 
      "javascriptreact" 
    },
    settings = {
      rootMarkers = {".git/"},
      languages = {
        lua = { lua_fmt },
        typescript = { deno_fmt },
        typescriptreact = { deno_fmt },
        javascript = { deno_fmt },
        javascriptreact = { deno_fmt },
      }
    },
    flags = {
      debounce_text_changes = 5000,
    },
  }
end

local function setup_null_ls()
  local null_ls = require('null-ls');
  -- FIXME: have issue when tryingt o format invalid document
  -- there is a long timeout before I can continue typing
  -- I don't have this with efm
  -- local deno_fmt = {
  --   method = null_ls.methods.FORMATTING,
  --   filetypes = {"typescript", "typescriptreact" },
  --   generator = null_ls.formatter({
  --     command = "deno",
  --     args = { "fmt", "-"},
  --     to_stdin = true
  --   }),
  -- }
  null_ls.config {
    debounce = 150,
    save_after_format = false,
    -- sources = { deno_fmt }
  }
  lspconfig["null-ls"].setup {
    on_attach = on_attach_common,
  }
end

local function setup_tsserver()
  lspconfig.tsserver.setup {
    flags = flags_common,
    on_attach = function(lsp_client, bufnr)
      lsp_client.resolved_capabilities.document_formatting = false
      lsp_client.resolved_capabilities.document_range_formatting = false

      local lsp_ts_utils = require("nvim-lsp-ts-utils")
      lsp_ts_utils.setup {
        eslint_enable_code_actions = false,
        update_imports_on_move = true,
        require_confirmation_on_move = true
      }
      lsp_ts_utils.setup_client(lsp_client)

      vim.api.nvim_exec([[
        command! -buffer OrganizeImports TSLspOrganize
      ]], false)

      on_attach_common(lsp_client, bufnr)
    end,
  }
end

local function setup_lua()
  local luadev = require("lua-dev").setup({
    lspconfig = {
      cmd = {"lua-langserver"},
      on_attach = on_attach_common,
    }
  })
  lspconfig.sumneko_lua.setup(luadev)
end

local function setup_jsonls()
  lspconfig.jsonls.setup {
    flags = flags_common,
    on_attach = on_attach_common,
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
        end
      }
    }
  }
end

local function setup_pylsp()
  lspconfig.pylsp.setup{
    flags = flags_common,
    on_attach = on_attach_common
  }
end

local function setup_vimls()
  lspconfig.vimls.setup {
    flags = flags_common,
    on_attach = on_attach_common
  }
end

local function setup_rust_analyzer()
  lspconfig.rust_analyzer.setup {
    flags = flags_common,
    on_attach = on_attach_common
  }
end

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = false,
    virtual_text = false,
    update_in_insert = true,
    severity_sort = true
  }
)

-- vim.lsp.set_log_level("debug")
setup_null_ls()
setup_efm()
setup_tsserver()
setup_lua()
setup_pylsp()
setup_jsonls()
setup_vimls()
setup_rust_analyzer()
