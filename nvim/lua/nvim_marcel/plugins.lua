return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  --  Sessions
  use {
    "folke/persistence.nvim",
    module = 'persistence',
    config = function()
      require("persistence").setup({
        dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
      });
    end,
    setup = function()
      vim.api.nvim_exec([[
        command LoadSession lua require("persistence").load()<cr>
        command StopSession lua require("persistence").stop()<cr>
        command VimLeavePre NerdTreeClose
      ]], false)
    end
  }

  -- Editor config support
  use 'editorconfig/editorconfig-vim'

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = "maintained",
        indent = { enable = true },
        context_commentstring = { enable = true },
        highlight = { enable = true, },
      }
    end
  }

  -- File explorer
  use {
    'preservim/nerdtree',
    opt = true,
    cmd = {'NERDTreeFind', 'NERDTreeToggle'},
    config = function()
      vim.api.nvim_exec([[
        let NERDTreeShowHidden=1
        let NERDTreeWinSize=35
      ]], false)
    end,
    setup = function()
      vim.api.nvim_exec([[
        nnoremap <silent><leader>; :NERDTreeToggle<CR>
        nnoremap <silent><leader>' :NERDTreeFind<CR>
      ]], false)
    end
  }

  --- Comment
  use 'tpope/vim-commentary'

  -- Git
  use 'tpope/vim-fugitive'

  --- Surround bindings
  use 'tpope/vim-surround'

  -- Formatter fallback for when I can't with LSP
  use {
    'sbdchd/neoformat',
    config = function()
      vim.api.nvim_exec([[
        let g:neoformat_enabled_typescript = ['denofmt']
        let g:neoformat_enabled_typescriptreact = ['denofmt']
      ]], false)
    end
  }

  -- Snippets
  use {
    'hrsh7th/vim-vsnip',
    requires = { 'hrsh7th/vim-vsnip-integ' },
    config = function()
      vim.api.nvim_exec([[
        let g:vsnip_filetypes = {}
        let g:vsnip_filetypes.javascriptreact = ['javascript']
        let g:vsnip_filetypes.typescriptreact = ['typescript']
        let g:vsnip_snippet_dir = expand('~/.config/nvim/vsnip')
      ]], false)
    end
  }

  -- LSP config helpers
  use {
    'neovim/nvim-lspconfig',
    requires = {
      "ray-x/lsp_signature.nvim",
      'nvim-lua/plenary.nvim', -- nvim-lsp-ts-utils
      "jose-elias-alvarez/nvim-lsp-ts-utils",
      "jose-elias-alvarez/null-ls.nvim",
      "folke/lua-dev.nvim"
    },
    config = function()
      require("nvim_marcel.config.lsp")
    end
  }

  -- Pretty LSP diagnostics, loc list or qf list
  use {
    "folke/trouble.nvim",
    config = function()
      require("nvim_marcel.config.trouble")
    end
  }

  -- Fuzzy finder and more
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
    },
    config = function()
      require("nvim_marcel.config.telescope")
    end
  }

  --- Git status in buffer (gutter, virtual_text)
  use {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup()
    end
  }

  -- Auto pair support
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({
        disable_filetype = { "TelescopePrompt" , "vim", "markdown" }
      })
    end
  }

  -- Auto close xml-like tag support
  use {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end
  }

  -- Autocompletion
  use {
    'hrsh7th/nvim-compe',
    wants = {'nvim-autopairs'},
    config = function()
      require("nvim_marcel.config.compe")
    end
  }

  -- Special mode: zen mode writing
  use {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
        plugins = {
          gitsigns = { enabled = true }
        }
      }
    end
  }

  -- Special mode: focus on current editing
  use {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {}
    end
  }

  -- Highlight colors
  use 'norcalli/nvim-colorizer.lua'

  -- Convert color codes easily
  use 'NTBBloodbath/color-converter.nvim'

  -- Color schemes
  use {'dracula/vim', as = 'dracula'}
  use 'ishan9299/nvim-solarized-lua'
  use 'projekt0n/github-nvim-theme'
  use {
    'folke/tokyonight.nvim',
    config = function()
      vim.api.nvim_exec([[
        let g:tokyonight_italic_comments = 0
        let g:tokyonight_italic_keywords = 0
      ]], false)
    end
  }
end)
