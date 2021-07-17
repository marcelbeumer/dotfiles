local M = {}

local replace_termcodes = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.setup_lsp_buffer(lsp_client, bufnr)
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
end

function M.setup_global()
  vim.api.nvim_exec([[
    nnoremap <silent>]q :cnext<CR>
    nnoremap <silent>[q :cprev<CR>
    nnoremap <silent>]Q :lnext<CR>
    nnoremap <silent>[Q :lprev<CR>
    nnoremap <silent>]t :tabnext<CR>
    nnoremap <silent>[t :tabprev<CR>
    nnoremap <silent><C-L> :tabnext<CR>
    nnoremap <silent><C-H> :tabprev<CR>

    nnoremap <silent><C-s> :w<CR>
    nnoremap <silent><C-w>N :vnew<CR>

    nnoremap <silent><leader>s :w<CR>
    nnoremap <silent><leader>tn :tabnew<CR>
    nnoremap <silent><leader>tc :tabclose<CR>
    nnoremap <silent><leader>; :NERDTreeToggle<CR>
    nnoremap <silent><leader>' :NERDTreeFind<CR>
    nnoremap <silent><leader>bx :BufferDeleteHidden<CR>

    nnoremap <leader>fx <cmd>lua require('telescope.builtin').builtin()<cr>
    nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
    nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
    nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
    nnoremap <leader>f/ <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>
    nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
    nnoremap <leader>flr <cmd>lua require('telescope.builtin').lsp_references()<cr>
    nnoremap <leader>fls <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
    nnoremap <leader>flS <cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>
    nnoremap <leader>fld <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
    nnoremap <leader>fla <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>
    nnoremap <leader>flq <cmd>lua require('telescope.builtin').lsp_document_diagnostics()<cr>
    nnoremap <leader>flQ <cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>

    " lsp-trouble global bindings because also needs to work in trouble buffer itself
    nnoremap <leader>xx <cmd>TroubleToggle<cr>
    nnoremap <leader>xw <cmd>TroubleToggle lsp_workspace_diagnostics<cr>
    nnoremap <leader>xd <cmd>TroubleToggle lsp_document_diagnostics<cr>
    nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
    nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
    nnoremap gR <cmd>TroubleToggle lsp_references<cr>

    inoremap <silent><expr> <C-Space> compe#complete()
    inoremap <silent><expr> <CR>      compe#confirm(luaeval("require 'nvim-autopairs'.autopairs_cr()"))
    inoremap <silent><expr> <C-e>     compe#close('<C-e>')
    inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
    inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
  ]], false)

  _G.__marcel_nvim__tab_complete = function() return M.tab_complete() end
  _G.__marcel_nvim__s_tab_complete = function() return M.s_tab_complete() end

  vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.__marcel_nvim__tab_complete()", {expr = true})
  vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.__marcel_nvim__tab_complete()", {expr = true})
  vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.__marcel_nvim__s_tab_complete()", {expr = true})
  vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.__marcel_nvim__s_tab_complete()", {expr = true})
end

function M.tab_complete()
  local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
      return true
    else
      return false
    end
  end
  if vim.fn.pumvisible() == 1 then
    return replace_termcodes "<C-n>"
  -- elseif vim.fn.call("vsnip#available", {1}) == 1 then
  --   return replace_termcodes "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return replace_termcodes "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end

function M.s_tab_complete()
  if vim.fn.pumvisible() == 1 then
    return replace_termcodes "<C-p>"
  -- elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
  --   return replace_termcodes "<Plug>(vsnip-jump-prev)"
  else
    return replace_termcodes "<S-Tab>"
  end
end

return M
