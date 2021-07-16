local M =  {}

function M.setup()
  -- Install packer
  local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  end

  vim.cmd 'packadd packer.nvim'

  require('packer').startup(function(use)
    -- Auto pair support
    -- use 'windwp/nvim-autopairs'
    -- use 'windwp/nvim-ts-autotag'

    -- Terminal colors
    use 'norcalli/nvim-terminal.lua'

    -- Welcome screen and session mgmt
    use 'mhinz/vim-startify'

    -- Autocompletion
    -- use { 'hrsh7th/nvim-compe', commit = '8024ea3b44db0e90b1048dfbf14cfb97439dd9c0' }
    use { 'hrsh7th/nvim-compe' }
    -- use 'marcelbeumer/nvim-compe'

    -- Treesitter tools
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- LSP config helpers
    use 'neovim/nvim-lspconfig'

    -- LSP enhancements for TS
    use { 'jose-elias-alvarez/nvim-lsp-ts-utils',
      requires = {{'nvim-lua/plenary.nvim'}, {'jose-elias-alvarez/null-ls.nvim'}}
    }

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
    -- use 'marcelbeumer/tokyonight.nvim'
    use 'folke/tokyonight.nvim'
    use 'projekt0n/github-nvim-theme'

    -- File explorer
    use 'preservim/nerdtree'

    -- Fuzzy finder
    use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }

    -- Native sorter for perf
    -- use { 'nvim-telescope/telescope-fzy-native.nvim' }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- Pretty LSP diagnostics, loc list or qf list
    use "folke/trouble.nvim"

    -- Highlight colors
    use 'norcalli/nvim-colorizer.lua'

    -- Rg command for fast searching
    use 'jremmen/vim-ripgrep'

    -- Editor config support
    use 'editorconfig/editorconfig-vim'

    -- Formatter fallback for when I can't with LSP
    use 'sbdchd/neoformat'

    -- Lua syntax
    use 'euclidianAce/BetterLua.vim'

    -- Snippets
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'
  end)
end

return M
