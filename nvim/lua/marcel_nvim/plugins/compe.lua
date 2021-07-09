local M =  {}

function M.setup()
  require'compe'.setup {
    enabled = true;
    autocomplete = false;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 20000;
    resolve_timeout = 20000;
    incomplete_delay = 40000;
    max_abbr_width = 1000;
    max_kind_width = 1000;
    max_menu_width = 1000;
    documentation = true;

    source = {
      -- path = true;
      -- buffer = true;
      -- calc = true;
      nvim_lsp = true;
      -- nvim_lua = true;
      -- vsnip = true;
      -- ultisnips = true;
    };
  }
end

return M
