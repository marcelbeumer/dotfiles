local cmp = require("cmp")

vim.o.completeopt = "menuone,noselect"

local check_back_space = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

cmp.setup({
  completion = {
    autocomplete = false,
  },
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp" },
  },
  sorting = {
    comparators = {
      cmp.config.compare.exact,
      cmp.config.compare.sort_text,

      -- defaults:
      -- cmp.config.compare.offset,
      -- cmp.config.compare.exact,
      -- cmp.config.compare.score,
      -- cmp.config.compare.kind,
      -- cmp.config.compare.sort_text,
      -- cmp.config.compare.length,
      -- cmp.config.compare.order,
    },
  },
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm(),
    ["<Tab>"] = function()
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(t("<C-n>"), "n")
      elseif check_back_space() then
        vim.fn.feedkeys(t("<Tab>"), "n")
      elseif vim.fn["vsnip#available"]() == 1 then
        vim.fn.feedkeys(t("<Plug>(vsnip-expand-or-jump)"), "")
      else
        -- do <S-Tab> to enter tab when char on backspace
        cmp.complete()
      end
    end,
  },
})

require("nvim-autopairs.completion.cmp").setup({
  map_cr = true, --  map <CR> on insert mode
  -- map_complete = true, -- it will auto insert `(` after select function or method item
  -- auto_select = true, -- automatically select the first item
})

local M = {}

M.get_lsp_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  return require("cmp_nvim_lsp").update_capabilities(capabilities)
end

return M
