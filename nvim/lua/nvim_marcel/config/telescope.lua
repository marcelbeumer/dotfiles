require("telescope").setup({
  defaults = {
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    generic_sorter = require("telescope.sorters").get_fzy_sorter,
    mappings = {
      i = {
        ["<C-q>"] = require("telescope.actions").send_to_qflist,
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})

local function split_str(v)
  local args = {}
  for s in string.gmatch(v, "%S+") do
    table.insert(args, s)
  end
  return args
end

function _G.__nvim_marcel__telescope_live_grep(v)
  local opts = {}
  if #v > 0 then
    opts.search_dirs = split_str(v)
  end
  require("telescope.builtin").live_grep(opts)
end

function _G.__nvim_marcel__telescope_find_files(v)
  local opts = {}
  if #v > 0 then
    opts.search_dirs = split_str(v)
  end
  require("telescope.builtin").find_files(opts)
end

vim.cmd([[
  command! -nargs=* -complete=file TelescopeLiveGrep lua __nvim_marcel__telescope_live_grep(<q-args>)
  command! -nargs=* -complete=file TelescopeFindFiles lua __nvim_marcel__telescope_find_files(<q-args>)

  nnoremap <leader>fx <cmd>lua require('telescope.builtin').builtin()<cr>
  nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
  nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
  nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
  nnoremap <leader>f/ <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>
  nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
  nnoremap <leader>flr <cmd>lua require('telescope.builtin').lsp_references()<cr>
  nnoremap <leader>fls <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
  nnoremap <leader>flS <cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>
  nnoremap <leader>fld <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
  nnoremap <leader>fla <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>
  nnoremap <leader>flq <cmd>lua require('telescope.builtin').lsp_document_diagnostics()<cr>
  nnoremap <leader>flQ <cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>
]])
