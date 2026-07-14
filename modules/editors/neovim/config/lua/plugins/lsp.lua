-- Runs for every LSP client that attaches to a buffer, regardless of whether
-- it was configured via `vim.lsp.config` or a plugin like typescript-tools.
local function on_attach(client, bufnr)
  local map = function(keys, func, desc) vim.keymap.set("n", keys, func, { desc = desc, buffer = bufnr }) end

  -- Neovim 0.11+ already provides these buffer-local defaults on LspAttach:
  --   grn -> rename          gra -> code action
  --   grr -> references      gri -> implementation
  --   grt -> type definition K   -> hover (but we've remapped K for Colemak,
  --                                 so keep an explicit hover map below)
  -- We only add mappings that fill gaps left by the defaults.
  map("gD", vim.lsp.buf.declaration, "Goto declaration (LSP)")
  map("gd", vim.lsp.buf.definition, "Goto definition (LSP)")
  map("<C-Space>", function() vim.lsp.buf.hover() end, "Hover info (LSP)")

  if client:supports_method("textDocument/inlayHint") then vim.lsp.inlay_hint.enable(true, { bufnr = bufnr }) end
end

local function setup_diagnostics()
  vim.diagnostic.config({
    severity_sort = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "✘",
        [vim.diagnostic.severity.WARN] = "▲",
        [vim.diagnostic.severity.HINT] = "⚑",
        [vim.diagnostic.severity.INFO] = "",
      },
    },
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
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client then on_attach(client, args.buf) end
        end,
      })

      vim.lsp.enable({
        "basedpyright",
        "clangd",
        "gopls",
        "html",
        "jsonls",
        "lua_ls",
        "terraformls",
        "yamlls",
      })

      setup_diagnostics()
      setup_keymaps()
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      settings = {
        expose_as_code_action = "all",
        complete_function_calls = true,
        code_lens = "off",
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "none",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = false,
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
