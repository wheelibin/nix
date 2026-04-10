local function on_attach(client, bufnr)
  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

  local map = function(keys, func, desc) vim.keymap.set("n", keys, func, { desc = desc, buffer = bufnr }) end

  map("gD", vim.lsp.buf.declaration, "Goto declaration (LSP)")
  map("gd", vim.lsp.buf.definition, "Goto definition (LSP)")
  map("<C-Space>", vim.lsp.buf.hover, "Hover info (LSP)")
  map("<leader>rn", vim.lsp.buf.rename, "Rename (LSP)")
end

local function setup_diagnostics()
  local signs = {
    { name = "DiagnosticSignError", text = "✘" },
    { name = "DiagnosticSignWarn", text = "▲" },
    { name = "DiagnosticSignHint", text = "⚑" },
    { name = "DiagnosticSignInfo", text = "" },
  }
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  vim.diagnostic.config({
    severity_sort = true,
    float = { border = "rounded", source = "if_many", header = "", prefix = "" },
  })
end

local function setup_keymaps()
  vim.keymap.set(
    "n",
    "<M-C-n>",
    function() vim.diagnostic.jump({ count = 1, float = true }) end,
    { desc = "Next diagnostic" }
  )

  vim.keymap.set(
    "n",
    "<M-C-e>",
    function() vim.diagnostic.jump({ count = -1, float = true }) end,
    { desc = "Previous diagnostic" }
  )
end

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      vim.lsp.config("*", {
        flags = { debounce_text_changes = 150 },
        on_attach = on_attach,
      })

      setup_diagnostics()
      setup_keymaps()

      vim.lsp.inlay_hint.enable(true)
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = on_attach,
      settings = {
        expose_as_code_action = "all",
        complete_function_calls = true,
        code_lens = "off",
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = false,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = false,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },
}
