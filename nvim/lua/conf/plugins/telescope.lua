local M = {}

local function split_str(v)
  local args = {}
  for s in string.gmatch(v, "%S+") do
    table.insert(args, s)
  end
  return args
end

M.live_grep = function(v)
  local opts = {}
  if #v > 0 then
    opts.search_dirs = split_str(v)
  end
  require("telescope.builtin").live_grep(opts)
end

M.find_files = function(v)
  local opts = {}
  if #v > 0 then
    opts.search_dirs = split_str(v)
  end
  require("telescope.builtin").find_files(opts)
end

-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#falling-back-to-find_files-if-git_files-cant-find-a-git-directory
M.project_files = function()
  local opts = {
    previewer = false,
    layout_strategy = "vertical",
    layout_config = { width = 0.5, height = 20, prompt_position = "top" },
  }
  local ok = pcall(require("telescope.builtin").git_files, opts)
  if not ok then
    require("telescope.builtin").find_files(opts)
  end
end

M.dirs = function()
  local opts = {
    previewer = false,
    prompt_title = "Find dirs",
    layout_strategy = "vertical",
    layout_config = { width = 0.5, height = 20, prompt_position = "top" },
    find_command = { "find", ".", "-type", "d" },
  }
  require("telescope.builtin").find_files(opts)
end

M.buffers = function()
  local opts = {
    previewer = false,
    layout_strategy = "vertical",
    layout_config = { width = 0.5, height = 20, prompt_position = "top" },
  }
  require("telescope.builtin").buffers(opts)
end

M.setup = function()
  local action_set = require("telescope.actions.set")
  require("telescope").setup({
    defaults = {
      layout_config = {
        prompt_position = "top",
      },
      mappings = {
        i = {
          ["<C-q>"] = require("telescope.actions").send_to_qflist,
        },
      },
    },
    pickers = {
      find_files = {
        -- workaround for folds not working when opening a file
        -- https://github.com/nvim-telescope/telescope.nvim/issues/559
        attach_mappings = function()
          action_set.select:enhance({
            post = function()
              vim.cmd(":normal! zx")
            end,
          })
          return true
        end,
      },
    },
  })

  require("telescope").load_extension("fzy_native")

  vim.cmd([[
    command! -nargs=* -complete=file TelescopeLiveGrep lua require('conf.plugins.telescope').live_grep(<q-args>)
    command! -nargs=* -complete=file TelescopeFindFiles lua require('conf.plugins.telescope').find_files(<q-args>)

    nnoremap <leader>ff <cmd>lua require('conf.plugins.telescope').project_files()<cr>
    nnoremap <leader>fb <cmd>lua require('conf.plugins.telescope').buffers()<cr>
    nnoremap <leader>fd <cmd>lua require('conf.plugins.telescope').dirs()<cr>
    nnoremap <leader>fx <cmd>lua require('telescope.builtin').builtin()<cr>
    nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
    nnoremap <leader>f/ <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>
    nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
    nnoremap <leader>flr <cmd>lua require('telescope.builtin').lsp_references()<cr>
    nnoremap <leader>fli <cmd>lua require('telescope.builtin').lsp_implementations()<cr>
    nnoremap <leader>fls <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
    nnoremap <leader>flS <cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>
    nnoremap <leader>fld <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
    nnoremap <leader>fla <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>
    nnoremap <leader>flq <cmd>lua require('telescope.builtin').lsp_document_diagnostics()<cr>
    nnoremap <leader>flQ <cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>
  ]])
end

return M
