return {
  { "neovim/nvim-lspconfig", lazy = true },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim",               opts = {} },
      "neovim/nvim-lspconfig",
      -- { "artemave/workspace-diagnostics.nvim" },
      { "j-hui/fidget.nvim",                  opts = {} }
    },
  }
}
