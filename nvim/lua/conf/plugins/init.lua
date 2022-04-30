local M = {}

M.setup = function()
  local packer = require("packer")
  packer.init()
  packer.reset()
  local use = packer.use

  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  -- Show key bindings panel on timeout
  use({
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({})
    end,
  })

  -- Distraction free writing
  use({
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup({
        width = 80,
      })
    end,
  })

  -- Lua interactive repl
  use("rafcamlet/nvim-luapad")

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
      require("conf.plugins.treesitter").setup()
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

  -- Lazygit inside nvim
  use("kdheepak/lazygit.nvim")

  --- Surround bindings
  use("tpope/vim-surround")

  -- Formatter fallback for when I can't with LSP
  use({
    "sbdchd/neoformat",
    opt = true,
    cmd = "Neoformat",
  })

  -- LSP config helpers
  use({
    "neovim/nvim-lspconfig",
    requires = {
      "nvim-lua/plenary.nvim", -- nvim-lsp-ts-utils
      "jose-elias-alvarez/nvim-lsp-ts-utils",
      "jose-elias-alvarez/null-ls.nvim",
      "rmagatti/goto-preview",
      "folke/lua-dev.nvim",
    },
    config = function()
      require("conf.plugins.lsp").setup()
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
      require("conf.plugins.telescope").setup()
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
    requires = {
      "hrsh7th/vim-vsnip",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    config = function()
      vim.cmd([[
        let g:vsnip_filetypes = {}
        let g:vsnip_filetypes.javascriptreact = ['javascript']
        let g:vsnip_filetypes.typescriptreact = ['typescript']
        let g:vsnip_snippet_dir = expand('~/.config/nvim/vsnip')
      ]])
      require("conf.plugins.cmp").setup()
    end,
  })

  use({
    "mfussenegger/nvim-dap",
    requires = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      require("dap-go").setup()
      require("dapui").setup()
    end,
  })

  use({
    "ray-x/go.nvim",
    config = function()
      require("go").setup()
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

  -- Color schemes
  use({
    "folke/tokyonight.nvim",
    setup = function()
      vim.g.tokyonight_style = "night"
      vim.g.tokyonight_italic_comments = false
      vim.g.tokyonight_italic_keywords = false
    end,
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  })
end

return M
