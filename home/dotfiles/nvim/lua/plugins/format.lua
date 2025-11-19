return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<leader>f",
        function()
          require("conform").format({ lsp_format = 'fallback' })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    -- Everything in opts will be passed to setup()
    opts = {
      -- Define your formatters
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { "prettier", "prettier", stop_after_first = true },
        typescript = { "prettier", "prettier", stop_after_first = true },
        css = { "prettier", "prettier", stop_after_first = true },
        html = { "prettier", "prettier", stop_after_first = true },
        go = { "goimports", "gofumpt", "golines" },
        markdown = { "mdformat" },
        sql = { "pg_format" }
      },
      -- Set up format-on-save
      format_on_save = function(bufnr)
        -- Disable autoformat on certain filetypes
        local ignore_filetypes = { "sql" }
        if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
          return
        end
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
    },
    init = function()
      -- If you want the formatexpr, here is the place to set it
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
