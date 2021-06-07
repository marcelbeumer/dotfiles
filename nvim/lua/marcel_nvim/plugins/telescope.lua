local M =  {}

function M.setup()
  local actions = require('telescope.actions')
  -- local trouble = require("trouble.providers.telescope")

  require('telescope').setup({
    defaults = {
      file_sorter = require'telescope.sorters'.get_fzy_sorter,
      generic_sorter = require'telescope.sorters'.get_fzy_sorter,
      mappings = {
        i = {
          ["<C-q>"] = actions.send_to_qflist,
          -- ["<C-t>"] = trouble.open_with_trouble, - conflicts but also doesnt work with other binding
        },
      }
    },
    extensions = {
      -- fzy_native = {
      --   override_generic_sorter = false,
      --   override_file_sorter = true,
      -- },
      fzf = {
        fuzzy = true,
        override_generic_sorter = false,
        override_file_sorter = true,
        case_mode = "smart_case",
      }
    }
  })
  -- require('telescope').load_extension('fzy_native')
  require('telescope').load_extension('fzy')
end

return M
