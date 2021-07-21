local M = {}

function M.setup()
  require('marcel_nvim.dev').setup()
  require('marcel_nvim.plugins.packer').setup()
  require('marcel_nvim.plugins.gitsigns').setup()
  require('marcel_nvim.plugins.autopairs').setup()
  require('marcel_nvim.plugins.autotag').setup()
  require('marcel_nvim.plugins.lsp').setup()
  require('marcel_nvim.plugins.compe').setup()
  require('marcel_nvim.plugins.treesitter').setup()
  require('marcel_nvim.plugins.neoformat').setup()
  require('marcel_nvim.plugins.vsnip').setup()
  require('marcel_nvim.plugins.nerdtree').setup()
  require('marcel_nvim.plugins.colorizer').setup()
  require('marcel_nvim.plugins.tokyonight').setup()
  require('marcel_nvim.plugins.trouble').setup()
  require('marcel_nvim.settings').setup_global()
  require('marcel_nvim.commands').setup_global()
  require('marcel_nvim.bindings').setup_global()
end

return M
