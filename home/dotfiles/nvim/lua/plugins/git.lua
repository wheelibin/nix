return {
  {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    config = function()
      require('gitsigns').setup({
        on_attach = function()
          local gs = package.loaded.gitsigns
          -- Navigation
          vim.keymap.set('n', '<M-C-H>', function()
            if vim.wo.diff then
              vim.cmd.normal({ ']c', bang = true })
            else
              gs.nav_hunk('next')
            end
          end, { expr = true, desc = "Goto next change/hunk (GIT)" })

          -- vim.keymap.set('n', '<M-C-,>', function()
          --   if vim.wo.diff then
          --     vim.cmd.normal({ '[c', bang = true })
          --   else
          --     gs.nav_hunk('prev')
          --   end
          -- end, { expr = true, desc = "Goto previous change/hunk (GIT)" })

          vim.keymap.set('n', '<leader>hr', gs.reset_hunk, { desc = "Reset change/hunk (GIT)" })
          vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { desc = "Preview Hunk (GIT)" })
        end
      })
    end
  }
}
