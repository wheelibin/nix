-- ~/.config/nvim/lsp/gopls.lua (Custom overrides for gopls)
-- This file MUST be located at 'lsp/gopls.lua' relative to your config root.
-- It should return a Lua table containing the settings to merge.
return {
  -- Example: Override capabilities (ensure your LSP client supports this)
  -- capabilities = {
  --   workspace = {
  --     didChangeWatchedFiles = { dynamicRegistration = false },
  --   },
  -- },
  settings = {
    gopls = {
      -- Example: Enable all inlay hints for gopls
      hints = {
        assignVariableTypes = false,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true, -- Example: Also enable constant value hints
        functionTypeParameters = true,
        parameterNames = false,
        rangeVariableTypes = true,
      },
      -- Example: Add build tags
      -- buildFlags = { "-tags=e2e,integration" },
      -- Add other gopls specific settings here
    },
  },
  -- Example: Add a custom on_attach specifically for gopls
  -- on_attach = function(client, bufnr)
  --   print("Attaching gopls with custom settings!")
  --   -- Add gopls-specific keymaps or logic here
  -- end,
}
