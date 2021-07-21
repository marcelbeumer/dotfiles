local lspconfig = require('lspconfig')

local flags_common = { debounce_text_changes = 300 }

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
  end
  if lsp_client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  if lsp_client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      augroup lsp_buffer
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
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
    filetypes = {"typescript", "typescriptreact" },
    settings = {
      rootMarkers = {".git/"},
      languages = {
        lua = { lua_fmt },
        typescript = { deno_fmt },
        typescriptreact = { deno_fmt },
      }
    },
    flags = {
      debounce_text_changes = 5000,
    },
  }
end

local function setup_lua()
  local sumneko_root_path = vim.env.HOME .. '/dev/clone/lua-language-server'
  local sumneko_binary = sumneko_root_path.."/bin/macOS/lua-language-server"

  lspconfig.sumneko_lua.setup {
    on_attach = on_attach_common,
    flags = flags_common,
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    filetypes = {"lua"},
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = vim.split(package.path, ';'),
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim', 'describe', 'after_each', 'before_each', 'it'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          },
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  }
end

local function setup_tsserver()
  lspconfig.tsserver.setup {
    flags = flags_common,
    on_attach = function(lsp_client, bufnr)
      -- Not sure if setting resolved_capabilities works
      lsp_client.resolved_capabilities.document_formatting = false
      lsp_client.resolved_capabilities.document_range_formatting = false

      -- required by lsp_ts_utils: https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils
      require("null-ls").config {}
      lspconfig["null-ls"].setup {}

      local lsp_ts_utils = require("nvim-lsp-ts-utils")
      lsp_ts_utils.setup {
        eslint_enable_code_actions = false,
        update_imports_on_move = true,
        require_confirmation_on_move = true
      }
      lsp_ts_utils.setup_client(lsp_client)

      on_attach_common(lsp_client, bufnr)
    end,
  }
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
    underline = true,
    virtual_text = false,
    update_in_insert = true,
    severity_sort = true
  }
)

-- vim.lsp.set_log_level("debug")
setup_tsserver()
setup_lua()
setup_pylsp()
setup_jsonls()
setup_vimls()
setup_rust_analyzer()
setup_efm()
