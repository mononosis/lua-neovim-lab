local M = {}
function M.setup()
  vim.api.nvim_set_keymap('n', '<leader>s', '<cmd>source %<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>!lua %<CR>', { noremap = true, silent = true })
end

return M
