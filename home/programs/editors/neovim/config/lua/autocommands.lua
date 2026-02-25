-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- set custom file highlighting
vim.api.nvim_create_autocmd("BufReadPost", { pattern = "Tiltfile", command = [[set filetype=python]] })
vim.api.nvim_create_autocmd("BufReadPost", { pattern = "Dockerfile*", command = [[set filetype=dockerfile]] })
vim.api.nvim_create_autocmd("BufReadPost", { pattern = "*.gql.tmpl", command = [[set filetype=graphql]] })
vim.api.nvim_create_autocmd("BufReadPost", { pattern = "*.http", command = [[set filetype=http]] })

vim.api.nvim_create_autocmd(
  { "FocusLost", "ModeChanged", "TextChanged", "BufEnter" },
  {
    pattern = "*",
    callback = function() vim.cmd("silent! update") end
  })
