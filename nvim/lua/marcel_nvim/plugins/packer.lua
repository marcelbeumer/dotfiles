local M =  {}

function M.setup()
  -- Install packer
  local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  end

  vim.cmd 'packadd packer.nvim'

  require('packer').startup(function(use)
    -- Welcome screen and session mgmt
    use 'mhinz/vim-startify'

    -- Autocompletion
    use 'hrsh7th/nvim-compe'

    -- Treesitter tools
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- LSP config helpers
    use 'neovim/nvim-lspconfig'

    -- LSP enhancements for TS
    use { 'jose-elias-alvarez/nvim-lsp-ts-utils' }

    --- Comment
    use 'tpope/vim-commentary'

    -- Git
    use 'tpope/vim-fugitive'

    --- Surround bindings
    use 'tpope/vim-surround'

    -- Support different commentstring settings within same filetype
    use 'JoosepAlviste/nvim-ts-context-commentstring'

    -- Colorschemes
    use {'dracula/vim', as = 'dracula'}
    use 'ishan9299/nvim-solarized-lua'
    use 'folke/tokyonight.nvim'
    use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
    use 'folke/lsp-colors.nvim' -- Add missing highlight groups in colorschemes

    -- File explorer
    use 'preservim/nerdtree'

    -- Fuzzy finder
    use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }

    -- Highlight colors
    use 'norcalli/nvim-colorizer.lua'

    -- Rg command for fast searching
    use 'jremmen/vim-ripgrep'

    -- Editor config support
    use 'editorconfig/editorconfig-vim'

    -- Formatting
    -- Issue with LSP formatting and treesitter:
    -- https://github.com/neovim/neovim/issues/12861
    use 'sbdchd/neoformat'

    -- Snippets
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'
  end)
end

return M
