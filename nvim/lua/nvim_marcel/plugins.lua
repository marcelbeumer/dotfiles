return require('packer').startup(function(use)

    -- Special mode: zen mode writing
    use {
      "folke/zen-mode.nvim",
      config = function()
        require("zen-mode").setup {}
      end
    }

    -- Special mode: focus on current editing
    use {
      "folke/twilight.nvim",
      config = function()
        require("twilight").setup {}
      end
    }

    -- Convert color codes easily
    use 'NTBBloodbath/color-converter.nvim'

    -- File explorer
    use {
      'preservim/nerdtree',
      config = function()
        vim.api.nvim_exec([[
          let NERDTreeShowHidden=1
          let NERDTreeWinSize=35
        ]], false)
      end
    }

    -- Fuzzy finder and more
    use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
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

end)
