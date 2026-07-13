return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<leader>f",
        function() require("conform").format({ lsp_format = "fallback" }) end,
        mode = "",
        desc = "Format buffer",
      },
    },
    config = function()
      require("conform").setup({
        -- Define your formatters
        formatters_by_ft = {
          bash = { "shfmt" },
          css = { "prettier" },
          go = { "goimports", "gofumpt", "golines" },
          html = { "prettier" },
          javascript = { "prettier" },
          json = { "prettier" },
          jsonc = { "prettier" },
          lua = { "stylua" },
          markdown = { "prettier" },
          nix = { "nixfmt" },
          python = { "isort", "black" },
          sh = { "shfmt" },
          sql = { "pg_format" },
          typescript = { "prettier" },
          typescriptreact = { "prettier" },
        },
        -- Set up format-on-save
        format_on_save = function(bufnr)
          -- Disable autoformat on certain filetypes
          local ignore_filetypes = { "sql" }
          if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then return end
          -- ...additional logic...
          return { timeout_ms = 5000, lsp_format = "fallback" }
        end,
        -- Customize formatters
        formatters = {
          shfmt = {
            prepend_args = { "-i", "2" },
          },
          pg_format = {
            args = { "--keyword-case=1", "--no-space-function", "--wrap-limit=80", "--spaces=2" },
          },
          golines = {
            args = { "--max-len=150" },
          },
        },
      })
    end,
    init = function()
      -- If you want the formatexpr, here is the place to set it
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
