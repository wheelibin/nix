return {
  { "neovim/nvim-lspconfig", lazy = true },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "basedpyright",
        "golangci_lint_ls",
        "gopls",
        "html",
        "jsonls",
        "lua_ls",
        "marksman",
        "terraformls",
        "vtsls",
        "yamlls",
      },
      automatic_installation = true,
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
      -- { "artemave/workspace-diagnostics.nvim" },
      { "j-hui/fidget.nvim",    opts = {} }
    },
  }
}
