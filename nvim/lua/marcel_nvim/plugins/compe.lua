local M =  {}

function M.setup()
  require'compe'.setup {
    enabled = true;
    autocomplete = false;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 2000;
    resolve_timeout = 2000;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
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
