local M = {}

function M.map(mode, l, r, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, l, r, options)
end

return M
