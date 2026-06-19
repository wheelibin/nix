-- [[ Highlight on yank ]]
-- See `:help vim.hl.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.hl.on_yank() end,
  group = highlight_group,
  pattern = "*",
})

-- set custom file highlighting
vim.api.nvim_create_autocmd("BufReadPost", { pattern = "Tiltfile", command = [[set filetype=python]] })
vim.api.nvim_create_autocmd("BufReadPost", { pattern = "Dockerfile*", command = [[set filetype=dockerfile]] })
vim.api.nvim_create_autocmd("BufReadPost", { pattern = "*.gql.tmpl", command = [[set filetype=graphql]] })
vim.api.nvim_create_autocmd("BufReadPost", { pattern = "*.http", command = [[set filetype=http]] })

vim.api.nvim_create_autocmd({ "FocusLost", "ModeChanged", "TextChanged", "BufEnter" }, {
  pattern = "*",
  callback = function() vim.cmd("silent! update") end,
})

-- [[ Treesitter highlight + indent ]]
-- Parsers + queries are provided by nix (see neovim.nix). The engine is
-- native, so we enable it per-buffer here instead of via nvim-treesitter's
-- (removed) `configs.setup({ highlight = ..., indent = ... })`. Folding uses
-- the native `vim.treesitter.foldexpr()` set in options.lua.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
  callback = function(args)
    -- Only start for filetypes that actually have a parser available.
    local ok = pcall(vim.treesitter.start, args.buf)
    if ok then vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
  end,
})
