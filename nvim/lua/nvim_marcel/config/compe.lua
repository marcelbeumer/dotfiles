vim.o.completeopt = "menuone,noselect"

require("compe").setup({
  enabled = true,
  autocomplete = false,
  debug = false,
  min_length = 1,
  preselect = "disable",
  throttle_time = 80,
  source_timeout = 2000,
  resolve_timeout = 2000,
  incomplete_delay = 4000,
  max_abbr_width = 1000,
  max_kind_width = 1000,
  max_menu_width = 1000,
  documentation = true,
  source = {
    path = true,
    -- buffer = true;
    -- calc = true;
    nvim_lsp = true,
    -- nvim_lua = true;
    vsnip = true,
    -- ultisnips = true;
  },
})

vim.cmd([[
  inoremap <silent><expr> <C-Space> compe#complete()
  inoremap <silent><expr> <CR> compe#confirm(luaeval("require 'nvim-autopairs'.autopairs_cr()"))
  inoremap <silent><expr> <C-e> compe#close('<C-e>')
  inoremap <silent><expr> <C-f> compe#scroll({ 'delta': +4 })
  inoremap <silent><expr> <C-d> compe#scroll({ 'delta': -4 })
]])

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.__nvim_marcel__tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.__nvim_marcel__tab_complete()", { expr = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.__nvim_marcel__s_tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.__nvim_marcel__s_tab_complete()", { expr = true })

local replace_termcodes = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local function tab_complete()
  local check_back_space = function()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
      return true
    else
      return false
    end
  end
  if vim.fn.pumvisible() == 1 then
    return replace_termcodes("<C-n>")
    -- elseif vim.fn.call("vsnip#available", {1}) == 1 then
    --   return replace_termcodes "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return replace_termcodes("<Tab>")
  else
    return vim.fn["compe#complete"]()
  end
end

local function s_tab_complete()
  if vim.fn.pumvisible() == 1 then
    return replace_termcodes("<C-p>")
    -- elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    --   return replace_termcodes "<Plug>(vsnip-jump-prev)"
  else
    return replace_termcodes("<S-Tab>")
  end
end

_G.__nvim_marcel__tab_complete = function()
  return tab_complete()
end
_G.__nvim_marcel__s_tab_complete = function()
  return s_tab_complete()
end
