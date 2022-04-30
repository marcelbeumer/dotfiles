local cmp = require("cmp")

local menuFormatMap = {
  buffer = "[buf]",
  nvim_lsp = "[lsp]",
  vsnip = "[vsnip]",
}

local M = {}

M.setup = function()
  vim.o.completeopt = "menuone,noselect"
  vim.o.pumheight = 10

  cmp.setup({
    experimental = {
      ghost_text = true,
    },
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    sources = {
      { name = "vsnip" },
      { name = "nvim_lsp" },
      { name = "nvim_lsp_signature_help" },
      -- { name = "buffer" },
    },
    sorting = {
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.locality,
        -- cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.score,
        cmp.config.compare.length,
        cmp.config.compare.order,

        -- defaults:
        -- cmp.config.compare.offset,
        -- cmp.config.compare.exact,
        -- cmp.config.compare.score,
        -- cmp.config.compare.recently_used,
        -- cmp.config.compare.locality,
        -- -- compare.scopes,
        -- cmp.config.compare.kind,
        -- cmp.config.ccompare.sort_text,
        -- cmp.config.ccompare.length,
        -- cmp.config.ccompare.order,
      },
    },
    mapping = {
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      ["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
    },
    formatting = {
      format = function(entry, vim_item)
        vim_item.menu = menuFormatMap[entry.source.name]
        return vim_item
      end,
    },
  })

  vim.cmd([[
  autocmd FileType markdown,text lua require('cmp').setup.buffer { enabled = false }
]])
end

M.get_lsp_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  return require("cmp_nvim_lsp").update_capabilities(capabilities)
end

return M
