local M = {}

function M.main()
  -- run with:
  -- nvim --headless -c 'lua require("nvim_marcel.debug").main()'
  print("Hello world")
  vim.cmd("exit")
end

return M
