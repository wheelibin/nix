return {
  {
    'echasnovski/mini.nvim',
    config = function()
      -- code commenting
      require('mini.comment').setup()

      -- highlight word under cursor
      require('mini.cursorword').setup({ delay = 400 })

      -- require('mini.animate').setup({
      --   -- scroll = { timing = function() return 2 end },
      --   scroll = { enable = false },
      --   resize = { enable = false }
      -- })

      -- remove buffers retaining window layout
      require('mini.bufremove').setup()
      vim.keymap.set("n", "<M-x>", "<cmd>lua require('mini.bufremove').delete()<cr>", { desc = 'Delete Buffer' })

      -- smart aligning
      require('mini.align').setup()

      -- sensible default options
      -- require('mini.basics').setup()

      -- require('mini.files').setup({
      --   -- content = {
      --   --   -- Predicate for which file system entries to show
      --   --   filter = nil,
      --   --   -- What prefix to show to the left of file system entry
      --   --   prefix = nil,
      --   --   -- In which order to show file system entries
      --   --   sort = nil,
      --   -- },
      --
      --   -- Module mappings created only inside explorer.
      --   -- Use `''` (empty string) to not create one.
      --   mappings = {
      --     close       = 'q',
      --     go_in       = 'i',
      --     go_in_plus  = 'I',
      --     go_out      = 'm',
      --     go_out_plus = 'M',
      --     mark_goto   = "'",
      --     mark_set    = 'b',
      --     reset       = '<BS>',
      --     reveal_cwd  = '@',
      --     show_help   = 'g?',
      --     synchronize = '=',
      --     trim_left   = '<',
      --     trim_right  = '>',
      --   },
      --
      --   -- -- General options
      --   -- options = {
      --   --   -- Whether to delete permanently or move into module-specific trash
      --   --   permanent_delete = true,
      --   --   -- Whether to use for editing directories
      --   --   use_as_default_explorer = true,
      --   -- },
      --   --
      --   -- -- Customization of explorer windows
      --   -- windows = {
      --   --   -- Maximum number of windows to show side by side
      --   --   max_number = math.huge,
      --   --   -- Whether to show preview of file/directory under cursor
      --   --   preview = false,
      --   --   -- Width of focused window
      --   --   width_focus = 50,
      --   --   -- Width of non-focused window
      --   --   width_nofocus = 15,
      --   --   -- Width of preview window
      --   --   width_preview = 25,
      --   -- },
      -- })
      -- vim.keymap.set("n", "<leader>fu", "<cmd>lua MiniFiles.open()<cr>", { desc = 'Mini Files' })
    end
  }
}
