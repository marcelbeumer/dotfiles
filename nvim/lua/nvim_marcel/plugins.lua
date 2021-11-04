return require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  -- Delete buffer helpers
  use({
    "kazhala/close-buffers.nvim",
    opt = true,
    module = "close-buffers",
    cmd = { "BDelete", "BWipeout" },
  })

  --  Sessions
  use({
    "folke/persistence.nvim",
    opt = true,
    event = "BufReadPre",
    module = "persistence",
    config = function()
      require("persistence").setup({
        dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
      })
    end,
    setup = function()
      vim.cmd([[
        command! LoadSession lua require("persistence").load()<cr>
        command! SaveSession lua require("persistence").save()<cr>
        command! StopSession lua require("persistence").stop()<cr>
        " VimLeavePre NerdTreeClose
      ]])
    end,
  })

  -- Editor config support
  use("editorconfig/editorconfig-vim")

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    requires = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "RRethy/nvim-treesitter-textsubjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = "maintained",
        indent = { enable = true },
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
        highlight = { enable = true },
        textsubjects = {
          enable = true,
          keymaps = {
            ["."] = "textsubjects-smart",
            [";"] = "textsubjects-container-outer",
          },
        },
      })
      vim.cmd([[
        set foldmethod=expr
        set foldexpr=nvim_treesitter#foldexpr()
        set foldlevelstart=99
      ]])
    end,
  })

  -- File explorer
  use({
    "preservim/nerdtree",
    opt = true,
    cmd = { "NERDTreeFind", "NERDTreeToggle" },
    config = function()
      vim.cmd([[
        let NERDTreeShowHidden=1
        let NERDTreeWinSize=35
      ]])
    end,
    setup = function()
      vim.cmd([[
        nnoremap <silent><leader>; :NERDTreeToggle<CR>
        nnoremap <silent><leader>' :NERDTreeFind<CR>
      ]])
    end,
  })

  --- Comment
  use({
    "terrortylor/nvim-comment",
    config = function()
      require("nvim_comment").setup({
        hook = function()
          require("ts_context_commentstring.internal").update_commentstring()
        end,
      })
    end,
  })

  -- Git
  use("tpope/vim-fugitive")

  --- Surround bindings
  use("tpope/vim-surround")

  -- Formatter fallback for when I can't with LSP
  use({
    "sbdchd/neoformat",
    opt = true,
    cmd = "Neoformat",
    config = function()
      vim.cmd([[
        let g:neoformat_enabled_typescript = ['denofmt']
        let g:neoformat_enabled_typescriptreact = ['denofmt']
      ]])
    end,
  })

  -- LSP config helpers
  use({
    "neovim/nvim-lspconfig",
    requires = {
      "nvim-lua/plenary.nvim", -- nvim-lsp-ts-utils
      "jose-elias-alvarez/nvim-lsp-ts-utils",
      "jose-elias-alvarez/null-ls.nvim",
      "folke/lua-dev.nvim",
    },
    config = function()
      require("nvim_marcel.config.lsp")
    end,
  })

  -- Pretty LSP diagnostics, loc list or qf list
  use({
    "folke/trouble.nvim",
    config = function()
      require("nvim_marcel.config.trouble")
    end,
  })

  -- Fuzzy finder and more
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzy-native.nvim" },
    },
    config = function()
      require("nvim_marcel.config.telescope").setup()
    end,
  })

  -- Auto pair support
  use({
    "windwp/nvim-autopairs",
    config = function()
      local ts_family_ts_config = { "template_string" }
      require("nvim-autopairs").setup({
        disable_filetype = { "TelescopePrompt", "vim", "markdown" },
        -- added open parentheses ( to the default value
        ignored_next_char = string.gsub([[ [%w%%%'%[%(%"%.] ]], "%s+", ""),
        ts_config = {
          javascript = ts_family_ts_config,
          javascriptreact = ts_family_ts_config,
          typescript = ts_family_ts_config,
          typescriptreact = ts_family_ts_config,
        },
      })
    end,
  })

  -- Autocompletion
  use({
    "hrsh7th/nvim-cmp",
    -- commit = "baa39271b2f6b52d8bc6a9789e795dfd662a8f2a",
    requires = {
      "hrsh7th/vim-vsnip",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
    },
    wants = { "nvim-autopairs" },
    config = function()
      vim.cmd([[
        let g:vsnip_filetypes = {}
        let g:vsnip_filetypes.javascriptreact = ['javascript']
        let g:vsnip_filetypes.typescriptreact = ['typescript']
        let g:vsnip_snippet_dir = expand('~/.config/nvim/vsnip')
      ]])
      require("nvim_marcel.config.cmp")
    end,
  })

  -- Special mode: zen mode writing
  use({
    "folke/zen-mode.nvim",
    opt = true,
    cmd = "ZenMode",
    config = function()
      require("zen-mode").setup({
        window = {
          width = 80,
        },
        plugins = {
          gitsigns = { enabled = true },
        },
      })
    end,
  })

  -- Special mode: focus on current editing
  use({
    "folke/twilight.nvim",
    opt = true,
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
    config = function()
      require("twilight").setup({})
    end,
  })

  -- Highlight colors
  use({
    "norcalli/nvim-colorizer.lua",
    opt = true,
    cmd = { "ColorizerAttachToBuffer", "ColorizerToggle" },
  })

  -- Convert color codes easily
  use({
    "NTBBloodbath/color-converter.nvim",
    opt = true,
    module = "color-converter",
    setup = function()
      vim.cmd([[
        command! ColorConvertHEX lua require('color-converter').to_hex()<CR>
        command! ColorConvertRGB lua require('color-converter').to_rgb()<CR>
        command! ColorConvertHSL lua require('color-converter').to_hsl()<CR>
      ]])
    end,
  })

  -- vim.g.tokyonight_style = "night"
  vim.g.tokyonight_italic_comments = false
  vim.g.tokyonight_italic_keywords = false

  -- Color schemes
  use({
    "folke/tokyonight.nvim",
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  })
end)
