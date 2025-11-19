-- lua/lsp.lua (Main LSP setup file)
-- Define global LSP settings using vim.lsp.config('*', ...)
-- These apply to ALL language servers unless overridden.
vim.lsp.config("*", {
  flags = {
    -- Debounce settings can improve performance
    debounce_text_changes = 150,
  },
  -- Example: Define common on_attach or capabilities here if desired
  on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    vim.keymap.set("n", 'gD', vim.lsp.buf.declaration, { desc = 'Goto declaration (LSP)', buffer = bufnr })
    vim.keymap.set("n", 'gd', vim.lsp.buf.definition, { desc = 'Goto definition (LSP)', buffer = bufnr })

    -- currently handled by fzf-lua
    --vim.keymap.set("n", 'gi', vim.lsp.buf.implementation, { desc = 'Goto implementation (LSP)', buffer = bufnr })
    vim.keymap.set("n", '<C-Space>', vim.lsp.buf.hover, { desc = 'LSP Hover Info', buffer = bufnr })
    vim.keymap.set("n", '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename (LSP)', buffer = bufnr })

    -- currently handled by fzf-lua
    --vim.keymap.set({ "n", "v" }, '<leader>ca', function() vim.lsp.buf.code_action() end, { desc = 'Code Actions (LSP)', buffer = bufnr })

    vim.keymap.set("n", '<leader>f', function() vim.lsp.buf.format({ async = true }) end,
      { desc = 'Format buffer', buffer = bufnr })

    -- require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
  end
})

-- Initialize lspconfig to add its configurations to the runtime path
require("lspconfig")

-- enable inlay hints
vim.lsp.inlay_hint.enable(true)

-- global keymaps
-----------------
vim.keymap.set("n", '<M-C-n>', function()
  vim.diagnostic.jump({ count = 1, float = true })
  -- vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = 'Next Diagnostics message' })

vim.keymap.set("n", '<M-C-e>', function()
  vim.diagnostic.goto_prev()
  -- vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = 'Previous Diagnostics message' })

-- visual tweaks
----------------
local sign = function(opts)
  vim.fn.sign_define(opts.name,
    { texthl = opts.name, text = opts.text, numhl = '' })
end
sign({ name = 'DiagnosticSignError', text = '✘' })
sign({ name = 'DiagnosticSignWarn', text = '▲' })
sign({ name = 'DiagnosticSignHint', text = '⚑' })
sign({ name = 'DiagnosticSignInfo', text = '' })

vim.diagnostic.config({
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many', header = '', prefix = '' }
})
