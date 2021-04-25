local M = {}
local lspconfig = require('lspconfig')

local on_attach_common = function(lsp_client, bufnr)
  require('marcel_nvim.bindings').setup_lsp_buffer(lsp_client, bufnr)
  require('marcel_nvim.settings').setup_lsp_buffer(lsp_client, bufnr)
  require('marcel_nvim.commands').setup_lsp_buffer(lsp_client, bufnr)
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
    }
  }
end

local function setup_lua()
  local sumneko_root_path = vim.env.HOME .. '/dev/clone/lua-language-server'
  local sumneko_binary = sumneko_root_path.."/bin/macOS/lua-language-server"

  lspconfig.sumneko_lua.setup {
    on_attach = on_attach_common,
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
          globals = {'vim'},
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
    on_attach = function(lsp_client, bufnr)
      -- Not sure if setting resolved_capabilities works
      lsp_client.resolved_capabilities.document_formatting = false
      lsp_client.resolved_capabilities.document_range_formatting = false
      on_attach_common(lsp_client, bufnr)
    end
  }
end

local function setup_jsonl()
  lspconfig.jsonls.setup {
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

local function setup_pyls()
  lspconfig.pyls.setup{
    on_attach = on_attach_common
  }
end

local function setup_vimls()
  lspconfig.vimls.setup {
    on_attach = on_attach_common
  }
end

local function setup_rust_analyzer()
  lspconfig.rust_analyzer.setup {
    on_attach = on_attach_common
  }
end

function M.setup()
  setup_tsserver()
  setup_lua()
  setup_pyls()
  setup_jsonl()
  setup_vimls()
  setup_rust_analyzer()
  -- setup_efm()
end

return M