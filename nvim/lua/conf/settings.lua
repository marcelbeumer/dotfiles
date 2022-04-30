local function nmap(lhs, rhs)
  vim.api.nvim_set_keymap("n", lhs, rhs, { silent = true, noremap = true })
end

local M = {}

M.setup = function()
  -- Visuals
  vim.opt.termguicolors = true
  -- vim.opt.laststatus = 3
  vim.opt.signcolumn = "yes"
  vim.opt.number = true
  -- Backup, swap
  vim.opt.swapfile = false
  -- Editing
  vim.opt.clipboard = "unnamed"
  vim.opt.hidden = true
  vim.opt.shortmess:append("c")
  vim.opt.updatetime = 800 -- for CursorHold event
  vim.opt.mouse = "nv" -- nice for window sizing
  vim.opt.expandtab = true
  vim.opt.shiftwidth = 2
  vim.opt.softtabstop = 2
  vim.opt.tabstop = 2
  vim.opt.smartindent = true
  vim.opt.ignorecase = true
  vim.opt.joinspaces = true
  vim.opt.linebreak = true
  vim.opt.timeoutlen = 500 -- for which_key

  -- Commands
  vim.cmd([[command W w]])
  vim.cmd([[command FilePath let @*=expand("%")]])
  vim.cmd([[command FilePathAbs let @*=expand("%:p")]])
  vim.cmd([[command FilePathHead let @*=expand("%:h")]])
  vim.cmd([[command FilePathTail let @*=expand("%:t")]])
  vim.cmd([[command Todo e ~/Notes/content/todo.md]])
  vim.cmd([[command Scratch e ~/Notes/content/scratch.md]])
  vim.cmd([[command Inbox e ~/Notes/content/inbox.md]])
  -- vim.cmd([[command Garc !git ar && git c -am "..."]])
  vim.cmd([[au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=200, on_visual=true}]])

  -- Bindings
  nmap("]q", ":cnext")
  nmap("]q", ":cnext<CR>")
  nmap("[q", ":cprev<CR>")
  nmap("]Q", ":lnext<CR>")
  nmap("[Q", ":lprev<CR>")
  nmap("]t", ":tabnext<CR>")
  nmap("[t", ":tabprev<CR>")
  nmap("<C-L>", ":tabnext<CR>")
  nmap("<C-H>", ":tabprev<CR>")
  nmap("<C-s>", ":w<CR>")
  nmap("<C-w>N", ":vnew<CR>")
  nmap("<leader>s", ":w<CR>")
  nmap("<leader>tn", ":tabnew<CR>")
  nmap("<leader>tb", ":tab sb %<CR>")
  nmap("<leader>tc", ":tabclose<CR>")
  nmap("<leader>bd", ":bdel<CR>")
end

return M
