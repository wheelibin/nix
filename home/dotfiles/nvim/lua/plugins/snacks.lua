return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
      { "<M-x>", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      {
        "<leader>lg",
        function()
          Snacks.lazygit({
            -- automatically configure lazygit to use the current colorscheme
            -- and integrate edit with the current neovim instance
            configure = true,
            theme_path = vim.fs.normalize(vim.fn.stdpath("cache") .. "/lazygit-theme.yml"),
            -- Theme for lazygit
            theme = {
              [241]                      = { fg = "Special" },
              activeBorderColor          = { fg = "MatchParen", bold = true },
              cherryPickedCommitBgColor  = { fg = "Identifier" },
              cherryPickedCommitFgColor  = { fg = "Function" },
              defaultFgColor             = { fg = "Normal" },
              inactiveBorderColor        = { fg = "FloatBorder" },
              optionsTextColor           = { fg = "Function" },
              searchingActiveBorderColor = { fg = "MatchParen", bold = true },
              selectedLineBgColor        = { bg = "Visual" }, -- set to `default` to have no background colour
              unstagedChangesColor       = { fg = "DiagnosticError" },
            },
            win = {
              style = "lazygit",
            },
          })
        end,
        desc = "Lazygit"
      },
    },
    opts = {
      bigfile = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = false },
    },
  }
}
