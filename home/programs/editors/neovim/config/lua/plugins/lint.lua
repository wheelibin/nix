return {
  {
    'mfussenegger/nvim-lint',
    event = "BufRead",
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        -- handled by an lsp
        -- go = { "golangcilint" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        -- Use the "*" filetype to run linters on all filetypes.
        -- ['*'] = { 'global linter' },
        -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
        -- ['_'] = { 'fallback linter' },
      }
      local events = { "BufWritePost", "BufReadPost", "InsertLeave" }
      vim.api.nvim_create_autocmd(events, {
        callback = function()
          lint.try_lint()
        end,
      })
    end
  }
}
