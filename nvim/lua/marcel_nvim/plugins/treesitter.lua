local M = {}

function M.setup()
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    indent = {
      enable = true
    },
    context_commentstring = {
      enable = true
    },
    highlight = {
      enable = true,
    },
  }
end

return M
